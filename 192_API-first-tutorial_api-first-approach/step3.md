The next step is to add the OpenAPI generator maven plugin to the project. Open the `pom.xml` file of your project and add the `openapi-generator-maven-plugin` as shown in the snippet below.



Switch to the editor and open the file 'devonfw/workspaces/main/api-first-tutorial/pom.xml'.

`devonfw/workspaces/main/api-first-tutorial/pom.xml`{{open}}




Replace the content of the file with the following code.


Click on 'Copy to Editor' to change it automatically.

<pre class="file" data-filename="devonfw/workspaces/main/api-first-tutorial/pom.xml" data-target="replace" data-marker="">
&lt;?xml version=&#34;1.0&#34;?&gt;
&lt;project xsi:schemaLocation=&#34;http://maven.apache.org/POM/4.0.0 https://maven.apache.org/xsd/maven-4.0.0.xsd&#34; xmlns=&#34;http://maven.apache.org/POM/4.0.0&#34;
    xmlns:xsi=&#34;http://www.w3.org/2001/XMLSchema-instance&#34;&gt;
  &lt;modelVersion&gt;4.0.0&lt;/modelVersion&gt;
  &lt;groupId&gt;com.devonfw.quarkus&lt;/groupId&gt;
  &lt;artifactId&gt;api-first-tutorial&lt;/artifactId&gt;
  &lt;version&gt;1.0.0-SNAPSHOT&lt;/version&gt;
  &lt;properties&gt;
    &lt;compiler-plugin.version&gt;3.8.1&lt;/compiler-plugin.version&gt;
    &lt;maven.compiler.release&gt;11&lt;/maven.compiler.release&gt;
    &lt;project.build.sourceEncoding&gt;UTF-8&lt;/project.build.sourceEncoding&gt;
    &lt;project.reporting.outputEncoding&gt;UTF-8&lt;/project.reporting.outputEncoding&gt;
    &lt;quarkus.platform.artifact-id&gt;quarkus-bom&lt;/quarkus.platform.artifact-id&gt;
    &lt;quarkus.platform.group-id&gt;io.quarkus.platform&lt;/quarkus.platform.group-id&gt;
    &lt;quarkus.platform.version&gt;2.6.1.Final&lt;/quarkus.platform.version&gt;
    &lt;surefire-plugin.version&gt;3.0.0-M5&lt;/surefire-plugin.version&gt;
  &lt;/properties&gt;
  &lt;dependencyManagement&gt;
    &lt;dependencies&gt;
      &lt;dependency&gt;
        &lt;groupId&gt;${quarkus.platform.group-id}&lt;/groupId&gt;
        &lt;artifactId&gt;${quarkus.platform.artifact-id}&lt;/artifactId&gt;
        &lt;version&gt;${quarkus.platform.version}&lt;/version&gt;
        &lt;type&gt;pom&lt;/type&gt;
        &lt;scope&gt;import&lt;/scope&gt;
      &lt;/dependency&gt;
    &lt;/dependencies&gt;
  &lt;/dependencyManagement&gt;
  &lt;dependencies&gt;
    &lt;dependency&gt;
      &lt;groupId&gt;io.quarkus&lt;/groupId&gt;
      &lt;artifactId&gt;quarkus-resteasy-jackson&lt;/artifactId&gt;
    &lt;/dependency&gt;
    &lt;dependency&gt;
      &lt;groupId&gt;io.quarkus&lt;/groupId&gt;
      &lt;artifactId&gt;quarkus-arc&lt;/artifactId&gt;
    &lt;/dependency&gt;
    &lt;dependency&gt;
      &lt;groupId&gt;io.quarkus&lt;/groupId&gt;
      &lt;artifactId&gt;quarkus-resteasy&lt;/artifactId&gt;
    &lt;/dependency&gt;
    &lt;dependency&gt;
      &lt;groupId&gt;io.quarkus&lt;/groupId&gt;
      &lt;artifactId&gt;quarkus-junit5&lt;/artifactId&gt;
      &lt;scope&gt;test&lt;/scope&gt;
    &lt;/dependency&gt;
    &lt;dependency&gt;
      &lt;groupId&gt;io.rest-assured&lt;/groupId&gt;
      &lt;artifactId&gt;rest-assured&lt;/artifactId&gt;
      &lt;scope&gt;test&lt;/scope&gt;
    &lt;/dependency&gt;
  &lt;/dependencies&gt;
  &lt;build&gt;
    &lt;plugins&gt;
      &lt;plugin&gt;
        &lt;groupId&gt;${quarkus.platform.group-id}&lt;/groupId&gt;
        &lt;artifactId&gt;quarkus-maven-plugin&lt;/artifactId&gt;
        &lt;version&gt;${quarkus.platform.version}&lt;/version&gt;
        &lt;extensions&gt;true&lt;/extensions&gt;
        &lt;executions&gt;
          &lt;execution&gt;
            &lt;goals&gt;
              &lt;goal&gt;build&lt;/goal&gt;
              &lt;goal&gt;generate-code&lt;/goal&gt;
              &lt;goal&gt;generate-code-tests&lt;/goal&gt;
            &lt;/goals&gt;
          &lt;/execution&gt;
        &lt;/executions&gt;
      &lt;/plugin&gt;
      &lt;plugin&gt;
        &lt;artifactId&gt;maven-compiler-plugin&lt;/artifactId&gt;
        &lt;version&gt;${compiler-plugin.version}&lt;/version&gt;
        &lt;configuration&gt;
          &lt;compilerArgs&gt;
            &lt;arg&gt;-parameters&lt;/arg&gt;
          &lt;/compilerArgs&gt;
        &lt;/configuration&gt;
      &lt;/plugin&gt;
      &lt;plugin&gt;
        &lt;artifactId&gt;maven-surefire-plugin&lt;/artifactId&gt;
        &lt;version&gt;${surefire-plugin.version}&lt;/version&gt;
        &lt;configuration&gt;
          &lt;systemPropertyVariables&gt;
            &lt;java.util.logging.manager&gt;org.jboss.logmanager.LogManager&lt;/java.util.logging.manager&gt;
            &lt;maven.home&gt;${maven.home}&lt;/maven.home&gt;
          &lt;/systemPropertyVariables&gt;
        &lt;/configuration&gt;
      &lt;/plugin&gt;
    &lt;/plugins&gt;
  &lt;/build&gt;
  &lt;profiles&gt;
    &lt;profile&gt;
      &lt;id&gt;native&lt;/id&gt;
      &lt;activation&gt;
        &lt;property&gt;
          &lt;name&gt;native&lt;/name&gt;
        &lt;/property&gt;
      &lt;/activation&gt;
      &lt;build&gt;
        &lt;plugins&gt;
          &lt;plugin&gt;
            &lt;artifactId&gt;maven-failsafe-plugin&lt;/artifactId&gt;
            &lt;version&gt;${surefire-plugin.version}&lt;/version&gt;
            &lt;executions&gt;
              &lt;execution&gt;
                &lt;goals&gt;
                  &lt;goal&gt;integration-test&lt;/goal&gt;
                  &lt;goal&gt;verify&lt;/goal&gt;
                &lt;/goals&gt;
                &lt;configuration&gt;
                  &lt;systemPropertyVariables&gt;
                    &lt;native.image.path&gt;${project.build.directory}/${project.build.finalName}-runner&lt;/native.image.path&gt;
                    &lt;java.util.logging.manager&gt;org.jboss.logmanager.LogManager&lt;/java.util.logging.manager&gt;
                    &lt;maven.home&gt;${maven.home}&lt;/maven.home&gt;
                  &lt;/systemPropertyVariables&gt;
                &lt;/configuration&gt;
              &lt;/execution&gt;
            &lt;/executions&gt;
          &lt;/plugin&gt;
        &lt;/plugins&gt;
      &lt;/build&gt;
      &lt;properties&gt;
        &lt;quarkus.package.type&gt;native&lt;/quarkus.package.type&gt;
      &lt;/properties&gt;
    &lt;/profile&gt;

    &lt;profile&gt;
      &lt;id&gt;apigen&lt;/id&gt;
      &lt;activation&gt;&lt;activeByDefault&gt;true&lt;/activeByDefault&gt;&lt;/activation&gt;
      &lt;build&gt;
        &lt;plugins&gt;
          &lt;plugin&gt;
            &lt;groupId&gt;org.openapitools&lt;/groupId&gt;
            &lt;artifactId&gt;openapi-generator-maven-plugin&lt;/artifactId&gt;
            &lt;version&gt;5.3.1&lt;/version&gt;
            &lt;executions&gt;
              &lt;execution&gt;
                &lt;phase&gt;generate-sources&lt;/phase&gt;
                &lt;goals&gt;
                  &lt;goal&gt;generate&lt;/goal&gt;
                &lt;/goals&gt;
                &lt;configuration&gt;
                  &lt;inputSpec&gt;${project.basedir}/src/main/resources/petstore-api.yaml&lt;/inputSpec&gt;
                  &lt;generatorName&gt;jaxrs-spec&lt;/generatorName&gt;
                  &lt;apiPackage&gt;com.devonfw.quarkus.openapi.petstore.rest.v1&lt;/apiPackage&gt;
                  &lt;modelPackage&gt;com.devonfw.quarkus.openapi.petstore.domain&lt;/modelPackage&gt;
                  &lt;configOptions&gt;
                    &lt;sourceFolder&gt;src/main/gen&lt;/sourceFolder&gt;
                    &lt;useSwaggerAnnotations&gt;false&lt;/useSwaggerAnnotations&gt;
                    &lt;useTags&gt;true&lt;/useTags&gt;
                    &lt;interfaceOnly&gt;true&lt;/interfaceOnly&gt;
                    &lt;generatePom&gt;true&lt;/generatePom&gt;
                  &lt;/configOptions&gt;
                &lt;/configuration&gt;
              &lt;/execution&gt;
            &lt;/executions&gt;
          &lt;/plugin&gt;
        &lt;/plugins&gt;
      &lt;/build&gt;
    &lt;/profile&gt;
  &lt;/profiles&gt;
&lt;/project&gt;
</pre>

Now every time you build the project, the plugin will generate the correspong Java code for this API in the `target` folder of the project.
