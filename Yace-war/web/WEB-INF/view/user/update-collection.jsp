<section id="main" class="whitebox"> <!-- main panel -->
    <c:if test="${!empty param.idCollection}">
        <sql:query var="coll" dataSource="Yacedb">
            SELECT * FROM ycollection WHERE ycollection.idYCOLLECTION = ? AND ycollection.owner = ?
            <sql:param value="${param.idCollection}"/>
            <sql:param value="${user.idYUSER}"/>
        </sql:query>
    </c:if>
    
<header>
    <input type="image" class="printicon" alt="Imprimer la page" title="Imprimer la page" src="./theme/default/img/img_trans.gif" />
    <c:choose>
        <c:when test="${!empty coll}">
            <h1>Modification de <strong>${coll.rows[0].theme}</strong></h1>
        </c:when>
        <c:otherwise>
            <h1>${pageTitle}</h1>
        </c:otherwise>
    </c:choose>
</header>

<section class="content"> <!-- contenu intÃ©ressant -->
    <aside id="toggletips"><strong>A I D E</strong></aside>

    <div class="wizardBox">
        <c:choose>
            <c:when test="${!empty coll}">
                <br><label for="theme">Thème actuel: <strong>${coll.rows[0].theme}</strong>. Le changer ?</label>
            </c:when>
            <c:otherwise>
                <br><label for="theme"><strong>Quel sera le thême de votre nouvelle collection ?</strong></label>
            </c:otherwise>
        </c:choose>
        <br><br><input type="text" id="theme" name="theme" <c:if test="${!empty coll}">value="${coll.rows[0].theme}"</c:if> required="required">
        <br><br><label for="isPrivate">Collection priv&eacute;e ?</label> <input type="checkbox" id="isPrivate" name="isPrivate" <c:if test="${!empty coll && !coll.rows[0].is_public}">checked="checked"</c:if> title="Décochez pour montrer votre collection aux visiteurs du site">
        <br><br><button class="y-button y-button-white" onclick="collectionNameVerif()">Je valide et j'enregistre !</button>
    </div>

    <form name="wizardcollection" method="POST" action="#"></form>
    <%-- <button class="y-button y-button-white" onclick="valid()">Je valide !</button> --%>
    
</section>

</section>

<script type="text/javascript">
function collectionNameVerif(){
$(document).ready(function(){
    var theme = $("#theme").val();
    
    theme = theme.trim();
    
    if(!theme || theme.length === 0 || (/^\s*$/).test(theme)) {
        alert("Veuillez entrer un thème pour la collection");
    } else {
        var collectionName = document.createElement("input");
        $(collectionName)
            .attr("type","hidden")
            .attr("name","name")
            .attr("value",theme);
        
        var publicIndicator = document.createElement("input");
        $(publicIndicator)
            .attr("type","hidden")
            .attr("name","isPublic")
            .attr(
                "value",
                ($("#isPrivate").attr("checked") != 'checked')?"true":"false"
            );
        
        $("form[name='wizardcollection']")
            .append(collectionName)
            .append(publicIndicator)
            .submit();
    }
});
}

</script>
