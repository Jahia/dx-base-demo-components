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

<c:if test="${not renderContext.editMode}">
    <!-- JS Page Level -->
    <template:addResources type="javascript" resources="plugins/cube-portfolio/jquery.cubeportfolio.js"/>
    <template:addResources type="javascript" resources="plugins/cube-portfolio/cube-portfolio-3.js"/>
</c:if>

<%-- Get the title of the companies list, if exists display above list --%>
<c:set var="title" value="${currentNode.properties['jcr:title'].string}"/>
<c:if test="${not empty title}">
    <div class="headline"><h2>${title}</h2></div>
</c:if>

<c:choose>
    <c:when test="${renderContext.editMode}">
        <template:include view="edit"/>
    </c:when>
    <c:otherwise>
        <%-- Start Cube-Portfolio Container --%>
        <div class="cube-portfolio margin-bottom-60">
            <div class="content-xs">
                    <%-- Add Cube-Portfolio filters container --%>
                    <%-- Get filter categories from the choice list of industries --%>
                <jcr:propertyInitializers var="options" nodeType="jdnt:company" name="industryCat"
                                          node="${currentNode}"/>

                <div id="filters-container" class="cbp-l-filters-text content-xs">
                    <div data-filter="*" class="cbp-filter-item-active cbp-filter-item"><fmt:message key="jdnt_companies.all"/></div>
                    |
                    <c:forEach items="${options}" var="option" varStatus="items">
                        <div data-filter=".${option.value.string}" class="cbp-filter-item">
                                ${option.displayName}
                        </div>
                        <c:if test="${not items.last}"> |</c:if>
                    </c:forEach>
                </div>
                    <%--/end Filters Container--%>
            </div>
                <%--start Agency Grid Container--%>
            <div id="grid-container" class="cbp-l-grid-agency">

                <c:set var="resourceReadOnly" value="${currentResource.moduleParams.readOnly}"/>
                    <%-- Displaying the view of inherited nodetype jnt:contentList and this view is loading all subnodes,
                                                            the view is setting modulemap that we get from the included template header --%>
                <template:include view="hidden.header"/>
                <c:set var="isEmpty" value="true"/>
                <c:forEach items="${moduleMap.currentList}" var="subchild" begin="${moduleMap.begin}"
                           end="${moduleMap.end}" varStatus="item">
                    <c:if test="${renderContext.editMode}">
                        <div class="cbp-item">
                    </c:if>
                    <template:module node="${subchild}" view="${moduleMap.subNodesView}"
                                     editable="${moduleMap.editable && !resourceReadOnly}"/>
                    <c:set var="isEmpty" value="false"/>
                    <c:if test="${renderContext.editMode}">
                        </div>
                    </c:if>
                </c:forEach>

                    <%-- If the list is empty then we will display a sample imgView and default view Highlight --%>
                <c:if test="${not empty moduleMap.emptyListMessage and (renderContext.editMode or moduleMap.forceEmptyListMessageDisplay) and isEmpty}">
                    <%-- Sample company --%>
                    <div class="cbp-item logos">
                        <div class="cbp-caption margin-bottom-20">
                            <div class="cbp-caption-defaultWrap">
                                <img src="${url.currentModule}/img/background.jpg" alt="">
                            </div>
                            <div class="cbp-caption-activeWrap">
                                <div class="cbp-l-caption-alignCenter">
                                    <div class="cbp-l-caption-body">
                                        <ul class="link-captions no-bottom-space">
                                            <li><a href="#"><i class="rounded-x fa fa-link"></i></a></li>
                                            <li><a href="${url.currentModule}/img/background.jpg" class="cbp-lightbox"
                                                   data-title="Company"><i class="rounded-x fa fa-search"></i></a></li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="cbp-title-dark">
                            <div class="cbp-l-grid-agency-title"><fmt:message key="jdnt_companies.company"/></div>
                            <div class="cbp-l-grid-agency-desc"><fmt:message
                                    key="jdnt_companies.company_description"/></div>
                        </div>
                    </div>
                </c:if>
            </div>

                <%--/end Agency Grid Container--%>
        </div>
        <%--/end Cube-Portfolio Container--%>

        <template:include view="hidden.footer"/>
    </c:otherwise>
</c:choose>


