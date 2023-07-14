## Objective
The objective of this lesson is demonstrate how to view and install the external dependencies that the lab's application requires.

## Key Concept: 12 Factor App - Dependencies
A key concept in the second principle of the 12 Factor App is that all independent code modules and libraries are listed as dependencies of the application and installed when the main application needs them at runtime, either for testing or general operation.

We're going to cover Dependencies in-depth in upcoming labs, but for now, the important thing to understand is that the lab's application has external dependencies, and they will be installed now.

## Steps

**Step 1:** Confirm you are in the working directory of the lab's application.

`pwd`{{execute}}

You should see the following output:

`/root/12factor`

**Step 2:** Confirm you are in correct GitHub Branch

`git branch`{{execute}}

You should see the following output:

`1-codebase.0.0.1`

**Step 3:** View the file, `package.json` which is the list of Node.Js dependencies the application requires.

`clear && cat package.json`{{execute}}

---

The list of dependencies is shown in this snippet of JSON.

```
  "devDependencies": {
    "chai": "^4.2.0",
    "mocha": "^6.2.0",
    "nyc": "^14.1.1",
    "supertest": "^4.0.2",
    "globby": "^10.0.1",
    "lnk": "^1.1.0"
  },
  "dependencies": {
    "dotenv": "^8.2.0",
    "uuid": "^3.3.3"
  }
```


**Step 4:** Install the dependencies

`npm install`{{execute}}

When installation of the dependencies is complete you will see output as follows:

```
added 245 packages from 699 contributors and audited 245 packages in 6.453s

24 packages are looking for funding
  run `npm fund` for details

found 0 vulnerabilities
```
You are now ready to view and analyze the application code.

***Next: Viewing the Application Code***