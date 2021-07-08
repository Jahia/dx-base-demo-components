<%@ taglib prefix="jcr" uri="http://www.jahia.org/tags/jcr" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="utility" uri="http://www.jahia.org/tags/utilityLib" %>
<%@ taglib prefix="template" uri="http://www.jahia.org/tags/templateLib" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="functions" uri="http://www.jahia.org/tags/functions" %>
<%@ taglib prefix="ui" uri="http://www.jahia.org/tags/uiComponentsLib" %>
<%--@elvariable id="currentNode" type="org.jahia.services.content.JCRNodeWrapper"--%>
<%--@elvariable id="propertyDefinition" type="org.jahia.services.content.nodetypes.ExtendedPropertyDefinition"--%>
<%--@elvariable id="type" type="org.jahia.services.content.nodetypes.ExtendedNodeType"--%>
<%--@elvariable id="out" type="java.io.PrintWriter"--%>
<%--@elvariable id="script" type="org.jahia.services.render.scripting.Script"--%>
<%--@elvariable id="scriptInfo" type="java.lang.String"--%>
<%--@elvariable id="workspace" type="java.lang.String"--%>
<%--@elvariable id="renderContext" type="org.jahia.services.render.RenderContext"--%>
<%--@elvariable id="currentResource" type="org.jahia.services.render.Resource"--%>
<%--@elvariable id="url" type="org.jahia.services.render.URLGenerator"--%>
<template:addResources type="javascript" resources="fa-v4-shims.min.js"/>
<template:addResources type="javascript" resources="fontawesome-all.min.js"/>

<%-- get the node properties --%>
<c:set var="title" value="${currentNode.properties['jcr:title'].string}"/>
<c:set var="description" value="${currentNode.properties['description'].string}"/>
<c:set var="icon" value="${currentNode.properties['faIcon'].string}"/>
<c:if test="${jcr:isNodeType(currentNode, 'jdmix:hasLink') and not empty currentNode.properties['internalLink']
and not empty currentNode.properties['internalLink'].node}">
    <c:set var="linkNode" value="${currentNode.properties['internalLink'].node}" />
</c:if>

<div class="service">
    <c:choose>
        <%-- if there is a link display, make the icon clickable --%>
        <c:when test="${not empty linkNode}">
            <a href="<template:module node="${linkNode}" view="hidden.contentURL" editable="false"/>"><i class="fa ${icon} service-icon"></i></a>
        </c:when>
        <c:otherwise><i class="fa ${icon} service-icon"></i></c:otherwise>
    </c:choose>
    <div class="desc">
        <h4>${title}</h4>

        <p>${description}</p>
        <%-- display a read more text link if a link has been provided --%>
        <c:if test="${not empty linkNode}">
            <a href="<template:module node="${linkNode}" view="hidden.contentURL" editable="false"/>" alt="${title}">
                <c:choose>
                    <c:when test="${jcr:isNodeType(currentNode, 'jdmix:buttonText')}">
                        <template:include view="hidden.buttonText"/>
                    </c:when>
                    <c:otherwise>
                        <fmt:message key="jdnt_highlight.readmore"/>
                    </c:otherwise>
                </c:choose>
            </a>
        </c:if>
    </div>
</div>
