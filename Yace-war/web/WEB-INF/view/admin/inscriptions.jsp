<section id="main" class="whitebox"> <!-- main panel -->

    <header>
        <h1>
            G&eacute;rer les <strong>inscriptions</strong>
        </h1>
    </header>

    <section class="content"> <!-- contenu intéressant -->
        <aside id="toggletips"><strong>A I D E</strong></aside>
        <%-- BEGIN REGSTRATION TEST --%>
            <sql:query var="subscribeOk" dataSource="Yacedb">
                SELECT * FROM ysetting WHERE ysetting.name = "subscribeOk" AND ysetting.val = "true"
            </sql:query>
            <c:choose>
                <c:when test="${!empty subscribeOk.rows}">
                    <h1>Les inscriptions sont <strong style="color: green">activ&eacute;es</strong></h1>
                    <p>
                        Cette fonctionnalit&eacute; permet <strong>uniquement</strong> d'activer ou d&eacute;sactiver les <strong>nouvelles inscriptions</strong> au site.<br>
                        Les utilisateurs <strong>d&eacute;j&agrave;  inscrits</strong> pourront toujours <strong>se connecter</strong>.
                    </p>
                    <button class="y-button y-button-red" id="toggleSubscribe" rel="#confirm">
                        d&eacute;sactiver les inscriptions
                    </button>
                </c:when>
                <c:otherwise>
                    <h1>Les inscriptions sont <strong style="color: red">d&eacute;sactiv&eacute;es</strong></h1>
                    <p>
                        Cette fonctionnalit&eacute; permet <strong>uniquement</strong> d'activer ou d&eacute;sactiver les <strong>nouvelles inscriptions</strong> au site.<br>
                        Les utilisateurs <strong>d&eacute;j&agrave;  inscrits</strong> pourront toujours <strong>se connecter</strong>.
                    </p>
                    <button class="y-button y-button-blue" id="toggleSubscribe" rel="#confirm">
                        activer les inscriptions
                    </button>
                </c:otherwise>
            </c:choose>
        <%-- END REGSTRATION TEST --%>
        

    </section>

</section>

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
