## Objective
The objective of this lesson is to examine code for the lab's demonstration application. 

The demonstration application is named, *Pinger*. The purpose of Pinger is to report information about the environment in which it is running. Pinger runs as a webserver.

Pinger is not very useful in its current version. We're going to "grow" Pinger over the course of a few labs as we demonstrate each of the twelve principles of 12 Factor App.

## Steps to Access the Application Code


**Step 1:** Confirm you are in the working directory of the lab's application.

`pwd`{{execute}}

You should see the following output:

`/root/12factor`

If you are not in that working directory, execute the following command: `cd /root/12factor`{{execute}}.

**Step 2:** Open the application code in the `vi` editor.

`vi server.js`{{execute}}

**Step 3:** Turn on line numbering in `vi`.

Press the ESC key: `^ESC`{{execute ctrl-seq}}

and then enter:

`:set number`{{execute}}


You will see current version of the Pinger code, which is written in Node.JS, in the `vi` editor with line numbers showing.

## Discussion of Application

This code for the demonstration application is Javascript that runs under [Node.js](https://nodejs.org/en/about/).

The code at lines 1 - 3 binds the external dependencies to the application code. The dependencies are Node.js packages which are libraries that contain logic that is intended to be shared among a variety of applications in a general manner. For example, the package, `dotenv` is a libary that reads the contents of a special file name `.env` to create environment variables that need be in memory and which the application will use.

The package `http` contains functions for creating and running a webserver. The package `uuid/v4` contains functions to generate random [universally unique identifiers](https://en.wikipedia.org/wiki/Universally_unique_identifier). 

([Dependencies](https://12factor.net/dependencies) is the second principle of 12 Factor App which we'll discuss in upcoming labs.)

Line 4 declares variable, `port`. The value of `port` is the [TCP/IP](https://www.pcmag.com/encyclopedia/term/tcpip-port) port on which the web server will listen for incoming requests. If there is an environment variable with the name `PINGER_PORT` defined in the runtime environment, that value will be used. Otherwise, the default value, `3000` will be assigned to the variable, `port`. 

Lines 6 -  16 is the Javascript function, `handleRequest` that accepts the HTTP `request` coming in from the internet. The function creates a simple HTTP `response` that returns a JSON object that reports the name of the application as well as the current time.

Line 18 is the intelligence that creates the actual web server using the function, [`http.createServer`](https://nodejs.org/dist/latest-v14.x/docs/api/http.html#http_http_createserver_options_requestlistener). The request handler function, `handleRequest` is passed to `createServer()` as a parameter.

The server binds to the port at Lines 20 - 22 in the function, `server.listen()`

Lines 24 -27 defined a function, `shutdown()`. The purpose of `shutdown()` is to gracefully stop the server from running. The notion of a graceful shut down is part of the ninth principle of 12 Factor App: [Disposability](https://12factor.net/disposability). We'll discuss Disposability in upcoming labs.

## Steps to Exit the Application Code

**Step 4:** Get out of `vi` line numbered view mode

Press the ESC key: `^ESC`{{execute ctrl-seq}}

**Step 5:** Exit `vi`

`:q!`{{execute}}

You have exited `vi`.

Now that you have a basic understanding of the code for the lab's demonstration application, we'll move on and look at how the runtime environment variable `PINGER_PORT` is set in the configuration file.

---

**Next: Viewing the Application's Configuration File**