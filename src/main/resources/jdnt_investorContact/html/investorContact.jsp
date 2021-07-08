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
<c:set var="props" value="${currentNode.properties}"/>

<div class="who">
    <h3>${currentNode.properties['firstname'].string}&nbsp;${currentNode.properties['lastname'].string}</h3>
    <ul class="list-unstyled">
        <c:if test="${not empty currentNode.properties['email'].string}">
            <li><a href="#"><i class="fa fa-envelope-o"></i><fmt:message
                    key="jdnt_investorContactForm.email"/>: ${currentNode.properties['email'].string}</a></li>
        </c:if>
        <c:if test="${not empty currentNode.properties['phone'].string}">
            <li><a href="#"><i class="fa fa-phone"></i><fmt:message
                    key="jdnt_investorContactForm.phone"></fmt:message>: ${currentNode.properties['phone'].string}</a>
            </li>
        </c:if>
        <c:if test="${not empty props['investorType'].string}">
            <li><a href="#"><fmt:message key="jdnt_investorContactForm.investorType"/>: <fmt:message
                    key="jdnt_investorContactForm.${props['investorType'].definition.name}.${props['investorType'].string}"/></a>
            </li>
        </c:if>
        <c:if test="${not empty props['contactReason'].string}">
            <li><a href="#"><fmt:message key="jdnt_investorContactForm.contactReason"/>: <fmt:message
                    key="jdnt_investorContactForm.${props['contactReason'].definition.name}.${props['contactReason'].string}"/></a>
            </li>
        </c:if>
        <c:if test="${not empty props['subscription'].string}">
            <li><a href="#"><fmt:message key="jdnt_investorContactForm.subscription"/>: <fmt:message
                    key="jdnt_investorContactForm.${props['subscription'].definition.name}.${props['subscription'].string}"/></a>
            </li>
        </c:if>
    </ul>
</div>
