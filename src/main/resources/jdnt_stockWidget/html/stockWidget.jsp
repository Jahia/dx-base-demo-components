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
<%--@elvariable id="currentAliasUser" type="org.jahia.services.usermanager.JahiaUser"--%>
<template:addResources type="css" resources="stockWidget/stockWidget.css" />
<template:addResources type="javascript" resources="plugins/flip/jquery.flip.js"/>
<template:addResources type="javascript" resources="custom/stockWidget.js"/>
<template:addResources type="javascript" resources="fa-v4-shims.min.js"/>
<template:addResources type="javascript" resources="fontawesome-all.min.js"/>

<c:set var="uuid" value="${currentNode.identifier}"/>
<template:addResources>
    <script>
        $(document).ready(function() {
            var stockWidget = $("#stock-widget" + "${uuid}");
            initFlip(stockWidget);

            var isFlippableWidget = isFlippable(stockWidget);
            var isRenderModeEnabled = ${renderContext.editMode};
            if(!isFlippableWidget) {
                stockWidget.find("#flipToChart" + "${uuid}").css( "display", "none" );

                // show alert if can't flip
                if(isRenderModeEnabled === true) {
                    stockWidget.find("#not-flippable-due-to-width-alert" + "${uuid}").css("display", "block");
                }
            } else if(isRenderModeEnabled === true) {
                $(document).on('close.bs.alert', function(e) {
                    e.preventDefault();
                    $('#not-flippable-due-to-editmode-alert' + '${uuid}').hide();
                });
            }
        });
    </script>
</template:addResources>

<c:set var="id" value="${fn:replace(uuid,'-', '')}"/>
<c:set var="stock" value="${fn:toUpperCase(currentNode.properties['stock'].string)}"/>
<c:set var="exchange" value="${fn:toUpperCase(currentNode.properties['stockExchange'].string)}"/>

<c:set var="interval" value="${currentNode.properties['interval'].string}"/>
<c:if test="${empty interval}">
    <c:set var="interval" value="86400"/>
</c:if>

<c:set var="period" value="${currentNode.properties['period'].string}"/>
<c:if test="${empty period}">
    <c:set var="period" value="3M"/>
</c:if>

<%-- Get the title, if exists display --%>
<c:set var="title" value="${currentNode.properties['jcr:title'].string}"/>
<c:if test="${not empty title}">
    <div class="headline"><h2>${title}</h2></div>
</c:if>

<div id="stock-widget${uuid}" class="card flippable-stock-widget stock-widget" onclick="flip(this, ${renderContext.editMode}, '${uuid}')">
    <div id="not-flippable-due-to-width-alert${uuid}" class="alert alert-warning">
        <fmt:message key="jdnt_stockWidget.notflippableDueToWidth"/>
    </div>
    <div id="not-flippable-due-to-editmode-alert${uuid}" class="alert alert-danger alert-dismissible">
        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
            <span aria-hidden="true">&times;</span>
        </button>
        <fmt:message key="jdnt_stockWidget.notflippableDueToEditMode"/>
    </div>
    <div class="front">
        <div class="stock-widget-wrapper">
            <div class="title color-theme">${stock}</div>
            <div class="description">
                <p>${requestScope.stockDescription}</p>
            </div>
            <div class="stock-price">
                <span class="currency-value"></span>
                <span class="stockvalue">${requestScope.stockValue}</span>
            </div>
            <div class="stock-variable">
                <c:choose>
                    <c:when test="${fn:indexOf(requestScope.stockVariation, '0') == 0}">
                        +
                    </c:when>
                    <c:when test="${fn:contains(requestScope.stockVariation, '+')}">
                        <div class='arrow'></div>
                    </c:when>
                    <c:when test="${fn:contains(requestScope.stockVariation, '-')}">
                        <div class='arrow-down'></div>
                    </c:when>
                </c:choose>
                ${requestScope.stockVariation}
            </div>
            <div class="stock-update"><fmt:message key="jdnt_stockWidget.lastUpdate"/>&nbsp;<fmt:formatDate
                    value="${currentNode.properties['jcr:lastModified'].time}"
                    pattern="dd/MMM/yyyy HH:mm"/>
            </div>
        </div>
        <i id="flipToChart${uuid}" class="flipToChart fa fa-area-chart fa-lg" title="<fmt:message key="jdnt_stockWidget.flipToChart"/>"></i>

    </div>
    <div class="back">
        <i class="fa fa-arrow-left fa-lg" title="<fmt:message key="jdnt_stockWidget.flipToPrice"/>"></i>
        <img src="https://finance.google.com/finance/getchart?q=${stock}&i=${interval}&p=${period}<c:if test="${not empty exchange}">&x=${exchange}</c:if> ">
    </div>
</div>