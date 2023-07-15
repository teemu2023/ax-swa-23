The OpenAPI generator is able to generate full REST services. Since we used the option &#39;&lt;interfaceOnly&gt;true&lt;/interfaceOnly&gt;&#39;, only the interface for this API is generated.
This allows us to create the REST service and implement the logic in it ourselves.

So, create a class `PetstoreRestService` which implements the API generated from the generator plugin. Use the code shown below.



If the parent directories aren't already in the project, 'mkdir -p' will create them for you. 

`mkdir -p /root/devonfw/workspaces/main/api-first-tutorial/src/main/java/com/devonfw/quarkus/petstore/rest/v1`{{execute T1}}

Switch to the editor and click 'Copy to Editor'. 

'PetstoreRestService.java' will be created automatically inside the newly created folder.

<pre class="file" data-filename="devonfw/workspaces/main/api-first-tutorial/src/main/java/com/devonfw/quarkus/petstore/rest/v1/PetstoreRestService.java">
package com.devonfw.quarkus.petstore.rest.v1;

import java.util.Collections;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

import javax.validation.Valid;

import com.devonfw.quarkus.openapi.petstore.domain.Pet;
import com.devonfw.quarkus.openapi.petstore.rest.v1.PetsApi;

public class PetstoreRestService implements PetsApi {

  private Set&lt;Pet&gt; pets = Collections.newSetFromMap(Collections.synchronizedMap(new LinkedHashMap&lt;&gt;()));

  @Override
  public void createPets(@Valid Pet pet) {

    pet.setId(Long.valueOf(this.pets.size()));
    this.pets.add(pet);
  }

  @Override
  public List&lt;Pet&gt; listPets(Integer limit) {

    if (limit == null)
      return this.pets.stream().collect(Collectors.toList());
    return this.pets.stream().limit(limit).collect(Collectors.toList());
  }

  @Override
  public Pet showPetById(String petId) {

    List&lt;Pet&gt; petList = this.pets.stream().filter(pet -&gt; pet.getId() == Long.valueOf(petId))
        .collect(Collectors.toList());
    if (petList.size() == 0)
      return null;
    return petList.get(0);
  }

}

</pre>

This code uses a simple list to store the entities. You can, of course, use more complex logic and store the data in a database, for example.
