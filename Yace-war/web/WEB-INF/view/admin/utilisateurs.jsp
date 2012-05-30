<section id="main" class="whitebox"> <!-- main panel -->

    <header>
        <h1>
            G&eacute;rer les <strong>utilisateurs</strong>
        </h1>
    </header>

    <section class="content"> <!-- contenu intéressant -->
        <aside id="toggletips"><strong>A I D E</strong></aside>
        
        <sql:query var="users" dataSource="Yacedb">
            SELECT * FROM yuser ORDER BY pseudo ASC
        </sql:query>
        <sql:query var="ranks" dataSource="Yacedb">
            SELECT * FROM yrank
        </sql:query>
            
        <h1>Liste des <strong>utilisateurs</strong></h1>
        
        <form name="userModif" method="POST"></form>
        <table id="tabEdition" class="y-table y-table-form y-table-center">
            <thead>
                <tr>
                    <th></th>
                    <th>Nom d'utilisateur</th>
                    <th>Email</th>
                    <th>Grade</th>
                    <th><img class="wheelicon" src="./theme/default/img/img_trans.gif" alt="Edition" title="Edition" /></th>
                </tr>
            </thead>
            <tbody>
                
                <c:forEach var="user" items="${users.rows}" varStatus="counter">
                    <tr id="user${user.idYUSER}" <c:if test="${counter.count % 2 != 0}">class="odd"</c:if>>
                        <td>
                            ${user.idYUSER}
                            <input type="hidden" name="idYUSER" value="${user.idYUSER}" />
                            <input type="hidden" name="mode" value="edit" />
                        </td>
                        <td><input type="text" name="pseudo" size="20" value="${user.pseudo}" required disabled="disabled" /></td>
                        <td><input type="text" name="email" size="50" value="${user.email}" required disabled="disabled" /></td>
                        <td>
                            <select name="rank" disabled="disabled">
                                <c:forEach var="rank" items="${ranks.rows}">
                                    <option value="${rank.idYRANK}" <c:if test="${rank.idYRANK == user.rank}">selected="selected"</c:if>>${rank.description}</option>
                                </c:forEach>
                            </select>
                        </td>
                        <td>
                            <div class="mgmtIcons">
                                <img class='editicon' src='./theme/default/img/img_trans.gif' alt='Editer' title='Editer' onclick='edit("user${user.idYUSER}")' />
                                <img class='deleteicon' src='./theme/default/img/img_trans.gif' alt='Supprimer' title='Supprimer' onclick='del("user${user.idYUSER}")' />
                            </div>
                            <div class="mgmtIcons">
                                <img class='undoicon' src='./theme/default/img/img_trans.gif' alt='Annuler' title='Annuler' onclick='undo("user${user.idYUSER}")' style='display: none;' />
                                <img class='validicon' src='./theme/default/img/img_trans.gif' alt='Valider' title='Valider' onclick='send("user${user.idYUSER}")' style='display: none;' />
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
            $("#"+name+" select").show().removeAttr("disabled");
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
            $("#"+name+" select").attr("disabled", "disabled");
            $(".undoicon , .validicon").hide();
            $(".editicon").show();
            $(".deleteicon").show();
        });
    }

    function send(name) {
        $(document).ready(function(){
            var id = document.createElement("input");
            id.setAttribute("type", "hidden");
            id.setAttribute("name", "idYUSER");
            id.setAttribute("value", $("#tabEdition #"+name+" input[name='idYUSER']").val());
            
            var mode = document.createElement("input");
            mode.setAttribute("type", "hidden");
            mode.setAttribute("name", "mode");
            mode.setAttribute("value", $("#tabEdition #"+name+" input[name='mode']").val());
            
            var pseudo = document.createElement("input");
            pseudo.setAttribute("type", "hidden");
            pseudo.setAttribute("name", "pseudo");
            pseudo.setAttribute("value", $("#tabEdition #"+name+" input[name='pseudo']").val());
            
            var email = document.createElement("input");
            email.setAttribute("type", "hidden");
            email.setAttribute("name", "email");
            email.setAttribute("value", $("#tabEdition #"+name+" input[name='email']").val());
            
            var rank = document.createElement("input");
            rank.setAttribute("type", "hidden");
            rank.setAttribute("name", "rank");
            rank.setAttribute("value", $("#tabEdition #"+name+" select[name='rank']").val());
                
            $("form[name='userModif']")
                .append(id)
                .append(mode)
                .append(pseudo)
                .append(email)
                .append(rank)
                .submit();
        });
    }

</script>