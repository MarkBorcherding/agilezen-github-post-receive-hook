# Now Native 

AgileZen now as this as a native ability in Github. [Read more](http://blog.agilezen.com/2012/01/10/github-integration/) at their blog. Don't expect anything new here.  

# A Github Post-Receive Hook for AgileZen


This is a super simple little Sinatra app to attach comments to an AgileZen board. Right now 
it will only look for comments on a single board.

## Requirements


* Ruby
* Sinatra 

You can easily spin up this app on Heroku. 

## Usage


Get your API key from AgileZen. It's probably a good idea to create user specifically for
the API and limit the privileges as needed.

Add the post receive hook in Github as follows.

```
https://wherever.com/?project_id=123&api_key=12342k3j4b287zs9d8vzsv9
```

Push commits to your Github repo with commit message that contains `/(?:task|story|card) #?(\d+)/i` and you'll see the commit appear in AgileZen.

<img src='https://github.com/MarkBorcherding/agilezen-github-post-receive-hook/wiki/screenshot.png'/>

# To Do
* Nothing.....now that it's native. 







