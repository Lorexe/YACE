
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

        <table id="tabEdition" class="y-table y-table-form">
            <thead>
                <tr>
                    <th/>
                    <th>Nom du grade</th>
                    <th>Nb. objets max</th>
                    <th>Admin?</th>
                    <th>
                        <img class="wheelicon" src="./theme/default/img/img_trans.gif" alt="Edition" title="Edition" />
                    </th>
                </tr>
            </thead>
            <tfoot>
            <form name="ranknew" method="POST">
                <input type="hidden" name="idYRANK" value="new" />
                <input type="hidden" name="mode" id="moderanknew" value="add" />
                <tr id="ranknew" <c:if test="${ranks.rowCount % 2 == 0}">class="odd"</c:if>>
                    <td>${ranks.rowCount+1}</td>
                    <td><input type="text" name="name" size="50" required /></td>
                    <td><input type="text" name="nbMax" size="13" required /></td>
                    <td><input type="checkbox" name="isAdmin" value="admin" /></td>
                    <td><img class="moreicon" src="./theme/default/img/img_trans.gif" alt="Ajouter" title="Ajouter" onclick="send('ranknew')" /></td>
                </tr>
            </form>
            </tfoot>
            <tbody>
                <c:forEach var="rank" items="${ranks.rows}">
                <form name="rank${rank.idYRANK}" method="POST">
                    <input type="hidden" name="idYRANK" value="${rank.idYRANK}" />
                    <input type="hidden" name="mode" id="moderank${rank.idYRANK}" value="edit" />
                    <tr id="rank${rank.idYRANK}" <c:if test="${rank.idYRANK % 2 != 0}">class="odd"</c:if>>
                        <td>${rank.idYRANK}</td>
                        <td><input type="text" name="name" size="50" value="${rank.description}" required disabled="disabled" /></td>
                        <td><input type="text" name="nbMax" size="13" value="${rank.nb_max_item}" required disabled="disabled" /></td>
                        <td><input type="checkbox" name="isAdmin" value="admin" <c:if test="${rank.is_admin}">checked="checked"</c:if> disabled="disabled" /></td>
                        <td>
                            <img class='editicon' src='./theme/default/img/img_trans.gif' alt='Editer' title='Editer' onclick='edit("rank${rank.idYRANK}")' />
                            <img class='deleteicon' src='./theme/default/img/img_trans.gif' alt='Supprimer' title='Supprimer' onclick='del("rank${rank.idYRANK}")' />
                            <img class='undoicon' src='./theme/default/img/img_trans.gif' alt='Annuler' title='Annuler' onclick='undo("rank${rank.idYRANK}")' style='display: none;' />
                            <img class='validicon' src='./theme/default/img/img_trans.gif' alt='Valider' title='Valider' onclick='send("rank${rank.idYRANK}")' style='display: none;' />
                        </td>
                    </tr>
                </form>
            </c:forEach>
            </tbody>
        </table>

    </section>

</section>

<div id="softstorage" style="display: none;"></div>

<!-- Modal dialogs -->
<!-- confirm dialog -->
<div class="modal modal-info whitebox" id="confirm">
    <header>
        <h1><strong>Confirmation</strong> attendue</h1>
    </header>
    <p>
        Vous effectuez une <strong>action</strong> qui demande une <strong>confirmation</strong>. Souhaitez-vous <strong>continuer</strong> ?
    </p>

    <p>
        <button class="close y-button y-button-red confirm-yes"> oui </button>
        <button class="close y-button y-button-blue"> non </button>
    </p>
</div>

<script type="text/javascript">
    function edit(name) {
        $(document).ready(function(){
            $("#mode"+name).removeAttr("value").attr("value","edit");
            activ(name);
        });
    }

    function del(name) {
        $(document).ready(function(){
            $("#mode"+name).removeAttr("value").attr("value","delete");
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
            $("form[name='"+name+"']").submit();
        });
    }

</script>