## Objective
The objective of this lesson is demonstrate how to execute the tests that ship with the lab's demonstration application as part of the code download from GitHub.

**Remember!** A key concept in the Codebase principle of 12 Factor App is that all assets relevant to an application are stored in the application's central repository. This includes application tests. The demonstration application, *Pinger* contains its tests.

## Steps

**Step 1:** Confirm you are in the working directory of the lab's application.

`pwd`{{execute}}

You should see the following output:

`/root/12factor`

If you are not in that working directory, execute the following command: `cd /root/12factor`{{execute}}.

**Step 2:** Run the tests that ship with the code.

`npm test`{{execute}}

Notice the tests of run. Two tests have passed as shown in the line:

`2 passing (31ms)`

Also notice that running the tests produced a [code coverage](https://www.techopedia.com/definition/22535/code-coverage) report, like so:

```

-----------|----------|----------|----------|----------|-------------------|
File       |  % Stmts | % Branch |  % Funcs |  % Lines | Uncovered Line #s |
-----------|----------|----------|----------|----------|-------------------|
All files  |      100 |       50 |      100 |      100 |                   |
 server.js |      100 |       50 |      100 |      100 |                 4 |
-----------|----------|----------|----------|----------|-------------------|

```

A coverage report describes how many lines of code were actually exercised in the testing session. While not part of 12 Factor App, the notion of testing all lines of code is an important concept in testing best practices. Unfortunately the test we've just run has not exercised 4 lines of code.

---

We've tested the application to verity that the code is operational. The next lesson is the get the application up and running.


***Next: Running the Application***