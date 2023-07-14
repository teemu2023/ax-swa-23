## Objective
The objective of this lesson is to demonstrate how to start the lab's demonstration application's webserver and then call the server using the `curl` command.

## Steps

**Step 1:** Confirm you are in the working directory of the lab's application.

`pwd`{{execute}}

You should see the following output:

`/root/12factor`

If you are not in that working directory, execute the following command: `cd /root/12factor`{{execute}}.

**Step 2:** Start the Pinger web server

`node server.js`{{execute}}

You will see the following output:

`API Server is listening on port 3030`


**Step 3:** In a second terminal window call the web server using the `curl` command

`curl http://localhost:3030`{{execute T2}}

You will see the following output:

```
{
    "appName": "Pinger",
    "currentTime": "2020-12-24T16:04:38.215Z",
    "PINGER_PORT": "3030"
}
```

Notice that the webserver is running on the port defined by environment variable, `PINGER_PORT` as declared in the configuration file, `.env`. 

As mentioned at the beginning of the lab, the **Codebase** principle of 12 Factor App is that all assets relevant to the application are stored along with the application code in a central repository. We'll look at the details of storing configuration information in the central repository in the lab that demonstrates the third principle of 12 Factor App: Configuration.

---

***CONGRATULATIONS!! You've finished the lab!*** Click the CONTINUE button to finish up

