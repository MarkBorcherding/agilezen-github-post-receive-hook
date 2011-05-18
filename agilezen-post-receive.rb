require 'sinatra'
require 'net/http'
require 'net/https'
require 'openssl'
require 'uri'
require 'json'



# Post a with a query string to identify the project_id and api_key
# e.g. http:/wherever.com/?project_id=123&api_key=i234b23j4b23r89f7szd98uih23ew
post "/" do

  http = Net::HTTP.new 'agilezen.com', 443
  http.use_ssl = true
  http.verify_mode = OpenSSL::SSL::VERIFY_NONE

  headers ={'X-Zen-ApiKey' => params[:api_key], 'Content-Type' => 'application/json'  }
  task_id_regex = /(?:story|card|task) #?(\d+)/i
  push = JSON.parse(params[:payload])

  return if push['base_ref']

  commits_with_task = push['commits'].select{|commit| task_id_regex.match(commit['message'])}
  commits_with_task.each do |commit|
    data = "{\"text\":\"#{comment_message_from commit }\"}"
    commit['message'].scan(task_id_regex).each do |story_id|
      path = "https://agilezen.com/api/v1/projects/#{params[:board_id]}/stories/#{story_id}/comments"
      http.post path,data, headers 
    end
  end
end

get "/" do
  "You just don't get this, do you?"
end


def comment_message_from(commit)
  commit_message = commit['message'].slice(0,commit['message'].index("\n") || 50 )
  "#{commit['author']['name']} commited [<a href='#{commit['url']}'>#{commit['id'].slice(0,7)}</a>] #{commit_message}"
end
