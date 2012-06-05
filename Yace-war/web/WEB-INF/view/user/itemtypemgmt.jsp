<section id="main" class="whitebox"> <!-- main panel -->

    <header>
        <h1>${pageHeaderTitle}</h1>
    </header>

    <section class="content">
        <aside id="toggletips"><strong>A I D E</strong></aside>

        <form method="post" action="itemtypemgmt">
            <input type="hidden" name="coll" value="${idColl}"/>
            
            <p><label for="name_type">Nom du type d'objet</label>  <input type="text" id="name_type" name="name_type" require/></p>
            
            <input type="hidden" name="nb_champs" id="nb_champs" value="2"/>
            <input type="hidden" name="type_0" value="Image"/>
            <input type="hidden" name="type_1" value="String"/>
            
            <table class="y-table y-table-form y-table-center">
                <thead>
                    <tr>
                        <th>Nom du champ</th>
                        <th>Type du champ</th>
                        <th></th>
                    </tr>
                </thead>
                <tfoot>
                    <tr>
                        <td>
                            <button type="button" id="button_add" name="button_add" class="y-button y-button-white">Ajouter un champ</button>
                        </td> 
                        <td colspan="2">
                            <input type="submit" name="button_validate" value="Valider l'ajout du type" class="y-button y-button-green" />
                        </td>
                    </tr>
                </tfoot>
                <tbody id="table_champs">
                    <tr>
                        <td><input type="text" name="name_0" value="Photo"/></td>
                        <td>Image</td>
                        <td></td>
                    </tr>
                    <tr class="odd">
                        <td><input type="text" name="name_1" value="Titre"/></td>
                        <td>Texte</td>
                        <td></td>
                    </tr>
                </tbody>
            </table>
        </form>
    </section>
</section>
            
<script type="text/javascript">
$(document).ready(function(){
    $("#button_add").click(function(){
        var tr = document.createElement("tr");
        var td_name = document.createElement("td");
        var td_type = document.createElement("td");
        var td_action = document.createElement("td");
        var input_name = document.createElement("input");
        var select_type = document.createElement("select");
        
        var nb_champs = $("#nb_champs").val();
        if(nb_champs%2==1)
            $(tr).attr("class", "odd");
        
        $(tr).attr("id", "tr_"+nb_champs);
        
        $(input_name).attr("type", "text")
                     .attr("name", "name_"+nb_champs)
                     .attr("id", "name_"+nb_champs);
               
        $(select_type).attr("name", "type_"+nb_champs)
                      .attr("id", "type_"+nb_champs);
        $(select_type).html("<option value='String'>Texte</option><option value='Image'>Image</option>");
        
        $(td_action).html("<img class='deleteicon' src='./theme/default/img/img_trans.gif' alt='Supprimer' title='Supprimer' onclick='del("+nb_champs+")' />");
        
        nb_champs++;
        $("#nb_champs").val(nb_champs);
        
        $(td_name).append(input_name);
        $(td_type).append(select_type);
        $(tr).append(td_name).append(td_type).append(td_action);
        $("#table_champs").append(tr);
    });
});

function del(id) {
    var nb_champs = $("#nb_champs").val();
    
    for(i=id; i<nb_champs-1; i++) {
        var name = $("#name_"+(i+1)).val();
        var type = $("#type_"+(i+1)).val();
        
        $("#name_"+i).val(name);
        $("#type_"+i).val(type);
    }
    
    $("#tr_"+(nb_champs-1)).remove();
    
    nb_champs--;
    $("#nb_champs").val(nb_champs);
}
</script>