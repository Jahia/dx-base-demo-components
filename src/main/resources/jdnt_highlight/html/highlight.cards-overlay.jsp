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
<%-- get the node properties --%>
<c:set var="title" value="${currentNode.properties['jcr:title'].string}"/>
<c:set var="description" value="${currentNode.properties['description'].string}"/>
<c:set var="image" value="${currentNode.properties['image'].node}"/>
<%-- photoswipe files --%>
<template:addResources type="css" resources="masonry.css"/>
<template:addResources type="css" resources="style.css"/>
<template:addResources type="css" resources="plugins/photoswipe/photoswipe.css"/>
<template:addResources type="css" resources="plugins/photoswipe/default-skin/default-skin.css"/>
<template:addResources type="javascript" resources="plugins/photoswipe/photoswipe.min.js"/>
<template:addResources type="javascript" resources="plugins/photoswipe/photoswipe-ui-default.min.js"/>
<template:addResources type="javascript" resources="fa-v4-shims.min.js"/>
<template:addResources type="javascript" resources="fontawesome-all.min.js"/>

<c:choose>
    <%-- If no image has been supplied for the image view, put a placeholder image in place --%>
    <c:when test="${empty image}">
        <c:url var="imageUrl" value="${url.currentModule}/img/background.jpg"/>
    </c:when>
    <c:otherwise>
        <c:url var="imageUrl" value="${image.url}" context="/"/>
    </c:otherwise>
</c:choose>

<%-- check if the link property has been used on this content --%>
<c:if test="${jcr:isNodeType(currentNode, 'jdmix:hasLink') and not empty currentNode.properties['internalLink']
and not empty currentNode.properties['internalLink'].node}">
    <c:set var="linkNode" value="${currentNode.properties['internalLink'].node}" />
    <template:module node="${linkNode}" view="hidden.contentURL" editable="false" var="linkUrl"/>
</c:if>


<c:if test="${jcr:isNodeType(currentNode.parent, 'jdnt:highlights')}">
    <c:set var="griditem" value="grid-item"/>
</c:if>

<div class="masonry-overlay ${griditem}  thumbnails grid-item-overlay thumbnail-style thumbnail-kenburn">
    <div class="thumbnail-img">
        <div class="overflow-hidden">
            <c:if test="${not renderContext.editMode}">
                <div class="caption-items">
                            <ul class="link-captions no-bottom-space">
                        <c:choose>
                            <c:when test="${not empty linkNode}">
                                <h3><a class="hover-effect" href="${linkUrl}">${fn:replace(title, fn:substring(title, 30, fn:length(title)), ' ...')}</a></h3>
                            </c:when>
                            <c:otherwise>
                                <h4>${fn:replace(title, fn:substring(title, 30, fn:length(title)), ' ...')}</h4>
                            </c:otherwise>
                        </c:choose>
                        <p>${fn:replace(description, fn:substring(description, 30, fn:length(description)), ' ...')}</p>
                        <c:if test="${not empty linkNode}">
                        <li><a href="${linkUrl}"><i class="rounded-x fa fa-link"></i></a></li>
                        </c:if>
                        <li><a href="${imageUrl}" class="msn-lightbox" data-title="${title}"><i
                                class="rounded-x fa fa-search"></i></a></li>
                    </ul>
                </div>
            </c:if>
            <%-- schemas for image objects, great for SEO and microformats --%>
            <figure itemprop="associatedMedia" itemscope itemtype="http://schema.org/ImageObject">
                <a href="${imageUrl}" class="image" itemprop="contentUrl" data-size="1000x667" >
                    <img src="${imageUrl}" class="img-responsive"  height="400" width="600" itemprop="thumbnail">
                </a>
           </figure>
        </div>
        <%-- will show only for the edit mode. --%>
        <c:if test="${renderContext.editMode}">
            <div class="caption-items">
                    <c:choose>
                        <c:when test="${not empty linkNode}">
                            <h3><a class="hover-effect" href="${linkUrl}">${fn:replace(title, fn:substring(title, 30, fn:length(title)), ' ...')}</a></h3>
                        </c:when>
                        <c:otherwise>
                            <h3>${fn:replace(title, fn:substring(title, 30, fn:length(title)), ' ...')}</h3>
                        </c:otherwise>
                    </c:choose>
                    <p>${fn:replace(description, fn:substring(description, 30, fn:length(description)), ' ...')}</p>
                    <%-- only display the read more text if a link has been provided --%>
                    <c:if test="${not empty linkNode}">
                        <a class="btn-more-2 hover-effect" href="${linkUrl}" alt="${title}">
                            <c:choose>
                                <c:when test="${jcr:isNodeType(currentNode, 'jdmix:buttonText')}">
                                    <template:include view="hidden.buttonText"/>
                                </c:when>
                                <c:otherwise>
                                    <fmt:message key="jdnt_highlight.readmore"/>
                                </c:otherwise>
                            </c:choose>
                            &nbsp;+
                        </a>
                    </c:if>
            </div>
        </c:if>
    </div>
</div>

