## Objective
The objective of this lesson is inspect the various files in the lab's codebase in order to get a sense of how all assets that make up the application are stored in the common repository and versioned according to GitHub branches.

## Key Concept: 12 Factor App - Codebase
A key concept in the first principle of 12 Factor App is that all the assets of an application are stored in a common source code repository. Assets include not only the code logic that makes up the application but all configuration information relevant to a given version, a list of dependencies that the main application requires, as well as any tests that are to be run against the application.


## Steps

**Step 1:** Confirm you are in the working directory of the lab's application.

`pwd`{{execute}}

You should see the following output:

`/root/12factor`

**Step 2:** Checkout the code from the GitHub branch for the version of the application code for this lab, in this case `1-codebase.0.0.1`.

`git checkout 1-codebase.0.0.1`{{execute}}

You'll see output as follows:

```
Branch '1-codebase.0.0.1' set up to track remote branch '1-codebase.0.0.1' from 'origin'.
Switched to a new branch '1-codebase.0.0.1'
```

**Step 3:** View the files in the branch:

`tree ./`{{execute}}

You'll see output as follows:

```
./
├── package.json
├── readme.md
├── server.js
└── test
    └── http-tests.js

1 directory, 4 files

```
**WHERE**

* `package.json` contains the list of external dependencies for the application.
* `readme.md` is the introductory readme documentation for the application.
* `server.js` is the application code, which has logic written in Node.JS and runs as an HTTP webserver.
* `test` is the directory that has files that contains code for testing the application.

**Step 4:** Also, there is a hidden file named, `.env` that contains environmental configuration setting(s) that the application will use. Let's confirm the file is there: 

`clear && ls -1Ap`{{execute}}

You'll see output as follows:

```
.env
.git/
package.json
readme.md
server.js
test/

```

Notice the `.env` file in the list. This file holds configuration information that will be used by the application. We'll demonstrate different aspects of configuration as they apply to 12 Factor App throughout the labs. The important thing to know for now is that the 12 Factor App configuration information is stored in the common repository according to the version of the code to which the configuration applies.

---

***Next: Installing Dependencies***