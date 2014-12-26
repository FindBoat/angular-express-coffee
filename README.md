# Angular Express With Coffee Boilerplate

This is a template project using [Node Express](http://expressjs.com/) as backend and [Angular](https://angularjs.org/) as frontend in [CoffeeScript](http://coffeescript.org).

The project is a extremely simple blog app to demonstrate the framework, features includes sign in/sign up, list all posts and create a new post. 

[MongoDB](http://www.mongodb.org/) is used as database and JWT token for authentication instead of cookie since tokens are more secure and mobile friendly ([token vs cookie](http://www.google.com/search?q=token+vs+cookie)).


## Requirements

* [NodeJs](http://nodejs.org)
* [Express](http://expressjs.com)
* [CoffeeScript](http://coffeescript.org)
* [Jade](http://jade-lang.com/)
* [Stylus](http://learnboost.github.io/stylus/)
* [bootstrap-stylus](https://github.com/Acquisio/bootstrap-stylus)
* [Nib](http://visionmedia.github.io/nib/)
* [Mongoose](https://github.com/LearnBoost/mongoose)
* [jsonwebtoken](https://github.com/auth0/node-jsonwebtoken)

## Install

```
git clone https://github.com/FindBoat/angular-express-coffee [project-name]
cd [project-name]
npm install
npm install -g coffeescript
```

## Run

In dev mode:
```
npm run dev
```

In prod mode:
```
npm run build
npm run start
```

## Structure

```
/.app                            `compiled js for server and manage, created on the fly`
    /manage
    /server
/public                          `compiled js and css for client, created on the fly`
/src
    /client
        /app
            /auth                `Views, controllers for sign in/sign up features`
            /blocks              `Reusable codes throughout different projects`
            /core                `Services used throughout the app`
            /posts               `Views, controllers for posts features`
            app.module.coffee    `Define the overall app module`
        index.jade
        styles.styl
    /server                      `CoffeeScript for server code`
        /config     
        /controllers             `Each controller is responsible for a single resource request`
        /models      
        app.coffee
        routes.coffee            `Route follows RESTful rule and requests are routed to the corresponding controller`
    /manage                      `Convenient management codes`
```

## Project Details

### Authentication

Instead of using cookie for authentication, I choose JWT due to better security and mobile friendly. After user 
login/signup, token is returned to client. For client, each request should contain 'x-access-token' in the HTTP 
header.

### RESTful

APIs follow RESTful rules, in this project, user and post are two resources and have corresponding route and APIs. 
Server uses different controllers and client uses Angular $resource.

### Compling

Since Express framework supports Jade & Stylus, we don't need to do much work to compile them. Boostrap-styl & nib 
are used, so we add few lines of code at src/server/app.coffee to config stylus compilation. Coffee is compiled into 
.app for server and manage code, and public/client for client code.

### Angular Structure

Instead of grouping code into /controllers, /services, /directives etc., it is recommended to group by features 
(otherwise you're gonna end up w/ huge folders when project becomes larger).

## Credits
* [express-coffee](https://github.com/twilson63/express-coffee) The server side code is mostly inspired by this project.
* [ng-demos](https://github.com/johnpapa/ng-demos) The Angular style and code organization are inspired by this project.
TODO: Write credits

## License

See LICENSE

## Contribute

pull requests are welcome

