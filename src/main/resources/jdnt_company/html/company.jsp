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
<%-- default company view --%>
<template:addResources type="javascript" resources="fa-v4-shims.min.js"/>
<template:addResources type="javascript" resources="fontawesome-all.min.js"/>

<jcr:nodeProperty node="${currentNode}" name="jcr:title" var="title"/>
<jcr:nodeProperty node="${currentNode}" name="headline" var="headline"/>
<jcr:nodeProperty node="${currentNode}" name="industryCat" var="category"/>
<jcr:nodeProperty node="${currentNode}" name="thumbnail" var="thumb"/>
<c:if test="${not empty thumb}">
    <template:module path="${thumb.node.path}" view="hidden.contentURL" editable="false" var="thumbURL"/>
</c:if>
<%--Set variable for company descriptions and remove HTML tags--%>
<c:set var="description" value="${functions:removeHtmlTags(currentNode.properties.headline.string)}"/>

<%--Start Item Container--%>
<div class="cbp-item ${category.string}">
    <div class="cbp-caption margin-bottom-20">
        <div class="cbp-caption-defaultWrap">
            <%-- company thumbnail image --%>
            <img src="${thumbURL}" alt="">
        </div>
        <div class="cbp-caption-activeWrap">
            <div class="cbp-l-caption-alignCenter">
                <div class="cbp-l-caption-body">
                    <%-- link to more information --%>
                    <ul class="link-captions no-bottom-space">
                        <li><a href="<c:url value='${url.base}${currentNode.path}.html'/>"><i
                                class="rounded-x fa fa-link"></i></a></li>
                        <li><a href="${thumbURL}" class="cbp-lightbox" data-title="${fn:escapeXml(title.string)}"><i
                                class="rounded-x fa fa-search"></i></a></li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
    <div class="cbp-title-dark">
        <div class="cbp-l-grid-agency-title"><a
                href="<c:url value='${url.base}${currentNode.path}.html'/>">${fn:escapeXml(title.string)}</a></div>
        <%--Shorten Company Description to 100 char --%>
        <div class="cbp-l-grid-agency-desc">${fn:replace(description, fn:substring(description, 50, fn:length(description)), ' ...')}</div>
    </div>
</div>
<%--/end Item Container--%>

