Now build and run the application.

We pass the option `quarkus.http.host=0.0.0.0` here so that the service is available in Katacoda from outside. For local testing, you do not need this.




Now you have to open another terminal. Click on the cd command twice and you will change to &#39;devonfw/workspaces/main/api-first-tutorial&#39; in terminal 2 automatically. The first click will open a new terminal and the second one will change the directory. Alternatively you can click on the &#39;+&#39;, choose the option &#39;Open New Terminal&#39; and run the cd command afterwards. 


`cd devonfw/workspaces/main/api-first-tutorial`{{execute T2}}


Run `mvn clean compile quarkus:dev -Dquarkus.http.host=0.0.0.0` with this command.
`mvn clean compile quarkus:dev -Dquarkus.http.host=0.0.0.0 `{{execute T2}} 




