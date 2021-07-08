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
<template:addResources type="javascript" resources="owl.carousel.js"/>
<template:addResources type="javascript" resources="owl-carousel.js"/>
<template:addResources type="css" resources="owl.carousel.css"/>
<template:addResources type="javascript" resources="fa-v4-shims.min.js"/>
<template:addResources type="javascript" resources="fontawesome-all.min.js"/>

<%-- Get the title of the carousel, if exists display above carousel --%>
<c:set var="title" value="${currentNode.properties['jcr:title'].string}"/>
<c:if test="${not empty title}">
    <div class="headline"><h2>${title}</h2></div>
</c:if>


<div class="owl-carousel-v1 margin-bottom-50">
    <!--navigation-->
    <div class="owl-navigation">
        <div class="customNavigation">
            <a class="owl-btn prev-v1"><i class="fa fa-angle-left"></i></a>
            <a class="owl-btn next-v1"><i class="fa fa-angle-right"></i></a>
        </div>
    </div>
    <!--end navigation-->

    <div class="owl-slider-ap owl-carousel owl-theme">
        <%-- for each carouselImg display using the carouselImg jsp --%>
        <c:set var="images" value="${jcr:getChildrenOfType(currentNode, 'jdnt:carouselImg')}"/>
        <%-- Test to see if carousel is empty, if so insert placeholder image --%>
        <c:choose>
            <c:when test="${fn:length(images) == 0}">
                <div class="item active">
                    <div class="owl-item owl-fix-width">
                        <div class="item">
                            <img class="img-responsive" src="${url.currentModule}/img/background.jpg"
                                 alt="placeholder"/>
                        </div>
                    </div>
                </div>
            </c:when>
            <c:otherwise>
                <c:forEach items="${images}" var="image" varStatus="item">
                    <div class="item<c:if test="${item.first}"> active</c:if>">
                        <template:module node="${image}" view="owl" nodeTypes="jdnt:carouselImg" editable="true"/>
                    </div>
                </c:forEach>
            </c:otherwise>
        </c:choose>
    </div>
</div>
<!-- End Owl Carousel v1 -->

<%--  if edit mode display button to add more images to the carousel --%>
<c:if test="${renderContext.editMode}">
    <template:module path="*"/>
</c:if>
