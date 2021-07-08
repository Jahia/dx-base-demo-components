<%@ page language="java" contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="template" uri="http://www.jahia.org/tags/templateLib" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="jcr" uri="http://www.jahia.org/tags/jcr" %>
<%@ taglib prefix="ui" uri="http://www.jahia.org/tags/uiComponentsLib" %>
<%@ taglib prefix="functions" uri="http://www.jahia.org/tags/functions" %>
<%@ taglib prefix="query" uri="http://www.jahia.org/tags/queryLib" %>
<%@ taglib prefix="utility" uri="http://www.jahia.org/tags/utilityLib" %>
<%@ taglib prefix="s" uri="http://www.jahia.org/tags/search" %>
<%--@elvariable id="currentNode" type="org.jahia.services.content.JCRNodeWrapper"--%>
<%--@elvariable id="out" type="java.io.PrintWriter"--%>
<%--@elvariable id="script" type="org.jahia.services.render.scripting.Script"--%>
<%--@elvariable id="scriptInfo" type="java.lang.String"--%>
<%--@elvariable id="workspace" type="java.lang.String"--%>
<%--@elvariable id="renderContext" type="org.jahia.services.render.RenderContext"--%>
<%--@elvariable id="currentResource" type="org.jahia.services.render.Resource"--%>
<%--@elvariable id="url" type="org.jahia.services.render.URLGenerator"--%>
<%-- metadata view of company --%>
<template:addResources type="javascript" resources="fa-v4-shims.min.js"/>
<template:addResources type="javascript" resources="fontawesome-all.min.js"/>

<jcr:nodeProperty node="${currentNode}" name="phone" var="phone"/>
<jcr:nodeProperty node="${currentNode}" name="email" var="email"/>
<jcr:nodeProperty node="${currentNode}" name="website" var="website"/>
<jcr:nodeProperty node="${currentNode}" name="j:street" var="street"/>
<jcr:nodeProperty node="${currentNode}" name="j:zipCode" var="zipCode"/>
<jcr:nodeProperty node="${currentNode}" name="j:town" var="town"/>
<jcr:nodeProperty node="${currentNode}" name="j:country" var="country"/>

<%-- display the headline title, get wording from resource files --%>
<div class="headline"><h2><fmt:message key="jdnt_company.headlineTitle"/></h2></div>
<ul class="list-unstyled who">
    <c:if test="${not empty street or not empty  town or not empty country}">
    <li><a href="https://maps.google.com?q=${street.string}+${town.string}+${zipCode.string}+${country.string}"><i
            class="fa fa-building-o"></i>${street.string}
        <br/><i class="fa fa-building-o" style="visibility: hidden;"></i>${town.string}&nbsp;${zipCode.string}&nbsp;-&nbsp;${country.string}
    </a>
        </c:if>
        <c:if test="${not empty email}">
    <li><a href="mailto:${email.string}"><i class="fa fa-envelope"></i>${email.string}</a></li>
    </c:if>
    <c:if test="${not empty phone}">
        <li><a href="tel:${phone.string}"><i class="fa fa-phone"></i>${phone.string}</a></li>
    </c:if>
    <c:if test="${not empty website.string and website.string != 'http://'}">
        <li><a href="${website.string}"><i class="fa fa-globe"></i>${website.string}</a></li>
    </c:if>
</ul>

<%-- If social icons have been added use mixin view to display --%>
<c:if test="${jcr:isNodeType(currentNode, 'jdmix:socialIcons')}">
    <template:include view="hidden.company"/>
</c:if>
