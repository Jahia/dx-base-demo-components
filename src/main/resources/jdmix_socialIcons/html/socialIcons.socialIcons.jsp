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
<template:addResources type="javascript" resources="fa-v4-shims.min.js"/>
<template:addResources type="javascript" resources="fontawesome-all.min.js"/>

<%-- if social icons were included, get the urls --%>
    <c:set var="facebook" value="${currentNode.properties.facebook.string}"/>
    <c:set var="linkedin" value="${currentNode.properties.linkedIn.string}"/>
    <c:set var="twitter" value="${currentNode.properties.twitter.string}"/>
    <c:set var="googlePlus" value="${currentNode.properties.googlePlus.string}"/>
<!-- Contact Social Icons -->
<ul class="list-inline team-social">
    <%-- check if the social icon links were properly filled in before displaying--%>
    <c:if test="${not empty facebook and facebook != 'http://'}">
        <li><a data-placement="top" data-toggle="tooltip" class="fb tooltips" data-original-title="Facebook"
               href="${facebook}"><i class="fa fa-facebook"></i></a></li>
    </c:if>
    <c:if test="${not empty twitter and twitter != 'http://'}">
        <li><a data-placement="top" data-toggle="tooltip" class="tw tooltips" data-original-title="Twitter"
               href="${twitter}"><i class="fa fa-twitter"></i></a></li>
    </c:if>
    <c:if test="${not empty googlePlus and googlePlus != 'http://'}">
        <li><a data-placement="top" data-toggle="tooltip" class="gp tooltips"
               data-original-title="Google plus" href="${googlePlus}"><i class="fa fa-google-plus"></i></a></li>
    </c:if>
    <c:if test="${not empty linkedin and linkedin != 'http://'}">
        <li><a data-placement="top" data-toggle="tooltip" class="ln	tooltips"
               data-original-title="Linkedin" href="${linkedin}"><i class="fa fa-linkedin"></i></a></li>
    </c:if>
    <li><c:url var="vcardUrl" value="${url.base}${currentNode.path}.vcf"/>
        <a data-placement="top" data-toggle="tooltip" class="vcard	tooltips"
           data-original-title="<fmt:message key="jnt_person.vcard"/>" href="${vcardUrl}"><i
                class="fa fa-vcard"></i></a></li>
</ul>
