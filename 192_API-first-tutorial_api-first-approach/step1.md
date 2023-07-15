In the first step, create the initial Quarkus project using the quarkus-maven-plugin on the command line.

When using this plugin, you need to pass the groupId and the artifactId. We additionally add the Quarkus resteasy-jackson extension, because we need it later.



Please change the folder to &#39;devonfw/workspaces/main&#39;.

`cd devonfw/workspaces/main`{{execute T1}}


Run `mvn io.quarkus.platform:quarkus-maven-plugin:2.6.1.Final:create -DprojectGroupId=com.devonfw.quarkus -DprojectArtifactId=api-first-tutorial -Dextensions=resteasy-jackson` with this command.
`mvn io.quarkus.platform:quarkus-maven-plugin:2.6.1.Final:create -DprojectGroupId=com.devonfw.quarkus -DprojectArtifactId=api-first-tutorial -Dextensions=resteasy-jackson `{{execute T1}} 


This command will create a folder `api-first-tutorial` in the workspace of the devonfw-ide.


