
<section id="main" class="whitebox"> <!-- main panel -->

    <header>
        <h1>
            G&eacute;rer les <strong>niveaux</strong> d'utilisateurs
        </h1>
    </header>

    <section class="content">
        <aside id="toggletips"><strong>A I D E</strong></aside>

        <sql:query var="ranks" dataSource="Yacedb">
            SELECT * FROM yrank
        </sql:query>
        <form name="rankModif" method="POST"></form>
        <table id="tabEdition" class="y-table y-table-form y-table-center">
            <thead>
                <tr>
                    <th></th>
                    <th>Nom du grade</th>
                    <th>Nb. objets max</th>
                    <th>Admin?</th>
                    <th>
                        <img class="wheelicon" src="./theme/default/img/img_trans.gif" alt="Edition" title="Edition" />
                    </th>
                </tr>
            </thead>
            <tfoot>
                <tr id="ranknew" <c:if test="${ranks.rowCount % 2 == 0}">class="odd"</c:if>>
                    <td>
                        ${ranks.rowCount+1}
                        <input type="hidden" name="idYRANK" value="new" />
                        <input type="hidden" name="mode" value="add" />
                    </td>
                    <td><input type="text" name="name" size="50" required /></td>
                    <td><input type="text" name="nbMax" size="13" required /></td>
                    <td><input type="checkbox" name="isAdmin" value="admin" /></td>
                    <td><img class="moreicon" src="./theme/default/img/img_trans.gif" alt="Ajouter" title="Ajouter" onclick="send('ranknew')" /></td>
                </tr>
            </tfoot>
            <tbody>
            <c:forEach var="rank" items="${ranks.rows}" varStatus="counter">
                <tr id="rank${rank.idYRANK}" <c:if test="${counter.count % 2 != 0}">class="odd"</c:if>>
                    <td>
                        ${rank.idYRANK}
                        <input type="hidden" name="idYRANK" value="${rank.idYRANK}" />
                        <input type="hidden" name="mode" value="edit" />
                    </td>
                    <td><input type="text" name="name" size="50" value="${rank.description}" required disabled="disabled" /></td>
                    <td><input type="text" name="nbMax" size="13" value="${rank.nb_max_item}" required disabled="disabled" /></td>
                    <td><input type="checkbox" name="isAdmin" value="admin" <c:if test="${rank.is_admin}">checked="checked"</c:if> disabled="disabled" /></td>
                    <td>
                        <div class="mgmtIcons">
                            <img class='editicon' src='./theme/default/img/img_trans.gif' alt='Editer' title='Editer' onclick='edit("rank${rank.idYRANK}")' />
                            <%-- <img class='deleteicon' src='./theme/default/img/img_trans.gif' alt='Supprimer' title='Supprimer' onclick='del("rank${rank.idYRANK}")' /> --%>
                        </div>
                        <div class="mgmtIcons">
                            <img class='undoicon' src='./theme/default/img/img_trans.gif' alt='Annuler' title='Annuler' onclick='undo("rank${rank.idYRANK}")' style='display: none;' />
                            <img class='validicon' src='./theme/default/img/img_trans.gif' alt='Valider' title='Valider' onclick='send("rank${rank.idYRANK}")' style='display: none;' />
                        </div>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>

    </section>

</section>

<div id="softstorage" style="display: none;"></div>

<script type="text/javascript">
    function edit(name) {
        $(document).ready(function(){
            $("#"+name+" input[name='mode']").removeAttr("value").attr("value","edit");
            activ(name);
        });
    }

    function del(name) {
        $(document).ready(function(){
            $("#"+name+" input[name='mode']").removeAttr("value").attr("value","delete");
            activ(name);
        });
    }

    function activ(name) {
        $(document).ready(function(){
            $("#"+name).clone().appendTo($("#softstorage"));
            $("#"+name+" input").show().removeAttr("disabled");
            $("#tabEdition tfoot").hide();
            $(".editicon").hide();
            $(".deleteicon").hide();
            $("#"+name+" .undoicon , #"+name+" .validicon").show();
        });
    }

    function undo(name) {
        $(document).ready(function(){
            $("#"+name).replaceWith($("#softstorage #"+name));
            $("#softstorage #"+name).remove();
            $("#"+name+" input").attr("disabled", "disabled");
            $(".undoicon , .validicon").hide();
            $("#tabEdition tfoot").show();
            $(".editicon").show();
            $(".deleteicon").show();
        });
    }

    function send(name) {
        $(document).ready(function(){
            var id = document.createElement("input");
            id.setAttribute("type", "hidden");
            id.setAttribute("name", "idYRANK");
            id.setAttribute("value", $("#tabEdition #"+name+" input[name='idYRANK']").val());
            
            var mode = document.createElement("input");
            mode.setAttribute("type", "hidden");
            mode.setAttribute("name", "mode");
            mode.setAttribute("value", $("#tabEdition #"+name+" input[name='mode']").val());
            
            var desc = document.createElement("input");
            desc.setAttribute("type", "hidden");
            desc.setAttribute("name", "name");
            desc.setAttribute("value", $("#tabEdition #"+name+" input[name='name']").val());
            
            var nbmax = document.createElement("input");
            nbmax.setAttribute("type", "hidden");
            nbmax.setAttribute("name", "nbMax");
            nbmax.setAttribute("value", $("#tabEdition #"+name+" input[name='nbMax']").val());
            
            var isadmin = document.createElement("input");
            isadmin.setAttribute("type", "checkbox");
            isadmin.setAttribute("name", "isAdmin");
            isadmin.setAttribute("value", "admin");
            if ($("#tabEdition #"+name+" input[name='isAdmin']").attr("checked") == "checked") {
                isadmin.setAttribute("checked", "checked");
            }
            
            
            $("form[name='rankModif']")
                .append(id)
                .append(mode)
                .append(desc)
                .append(nbmax)
                .append(isadmin)
                .submit();
        });
    }

</script>