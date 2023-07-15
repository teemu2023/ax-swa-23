To create the REST service with the OpenAPI generator, you need the OpenAPI specification for the service. When developing with the &#34;API first&#34; strategy, the API specification is planned before developing the actual REST service.

For this tutorial we will use a predefined API called &#39;Petstore&#39;. You can find this and some more examples on the [GitHub repository of OpenAPI-Specification](https://github.com/OAI/OpenAPI-Specification/tree/main/schemas).

So, create a file `petstore-api.yaml` in the folder `src/main/resources` of the Quarkus project.


If the parent directories aren't already in the project, 'mkdir -p' will create them for you. 

`mkdir -p /root/devonfw/workspaces/main/api-first-tutorial/src/main/resources`{{execute T1}}

Switch to the editor and click 'Copy to Editor'. 

'petstore-api.yaml' will be created automatically inside the newly created folder.

<pre class="file" data-filename="devonfw/workspaces/main/api-first-tutorial/src/main/resources/petstore-api.yaml">
openapi: &#34;3.0.0&#34;
info:
  version: 1.0.0
  title: Swagger Petstore
  license:
    name: MIT
servers:
  - url: http://petstore.swagger.io/v1
paths:
  /pets:
    get:
      summary: List all pets
      operationId: listPets
      tags:
        - pets
      parameters:
        - name: limit
          in: query
          description: How many items to return at one time (max 100)
          required: false
          schema:
            type: integer
            format: int32
      responses:
        &#39;200&#39;:
          description: A paged array of pets
          headers:
            x-next:
              description: A link to the next page of responses
              schema:
                type: string
          content:
            application/json:
              schema:
                $ref: &#34;#/components/schemas/Pets&#34;
        default:
          description: unexpected error
          content:
            application/json:
              schema:
                $ref: &#34;#/components/schemas/Error&#34;
    post:
      summary: Create a pet
      operationId: createPets
      tags:
        - pets
      requestBody:
        content:
          application/json:
            schema:
              $ref: &#39;#/components/schemas/Pet&#39;
      responses:
        &#39;201&#39;:
          description: Null response
        default:
          description: unexpected error
          content:
            application/json:
              schema:
                $ref: &#34;#/components/schemas/Error&#34;
  /pets/{petId}:
    get:
      summary: Info for a specific pet
      operationId: showPetById
      tags:
        - pets
      parameters:
        - name: petId
          in: path
          required: true
          description: The id of the pet to retrieve
          schema:
            type: string
      responses:
        &#39;200&#39;:
          description: Expected response to a valid request
          content:
            application/json:
              schema:
                $ref: &#34;#/components/schemas/Pet&#34;
        default:
          description: unexpected error
          content:
            application/json:
              schema:
                $ref: &#34;#/components/schemas/Error&#34;
components:
  schemas:
    Pet:
      type: object
      required:
        - id
        - name
      properties:
        id:
          type: integer
          format: int64
        name:
          type: string
        tag:
          type: string
    Pets:
      type: array
      items:
        $ref: &#34;#/components/schemas/Pet&#34;
    Error:
      type: object
      required:
        - code
        - message
      properties:
        code:
          type: integer
          format: int32
        message:
          type: string
</pre>

