<%@ taglib prefix="jcr" uri="http://www.jahia.org/tags/jcr" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="utility" uri="http://www.jahia.org/tags/utilityLib" %>
<%@ taglib prefix="template" uri="http://www.jahia.org/tags/templateLib" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="functions" uri="http://www.jahia.org/tags/functions" %>
<%@ taglib prefix="ui" uri="http://www.jahia.org/tags/uiComponentsLib" %>
<%@ page import="java.util.Date" %>
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

<jsp:useBean id="now" class="java.util.Date" />
<c:set var="tomorrow" value="<%=new Date(new Date().getTime() + 60*60*24*1000)%>"/>
<fmt:formatDate pattern="MMMM" dateStyle="long" value="${now}" var="newsMonth"/>
<fmt:formatDate pattern="d/M/yy" dateStyle="short" value="${now}" var="newsDate"/>
<fmt:formatDate pattern="d/M/yy" dateStyle="short" value="${tomorrow}" var="newsTomorrowDate"/>



    <li>
        <div class="timeline-badge primary"><i class="glyphicon glyphicon-record"></i></div>
        <div class="timeline-panel">
            <div class="timeline-heading">
                <img class="img-responsive" src="${url.currentModule}/img/background.jpg" alt="">
            </div>
            <div class="timeline-body text-justify">
                <h2><a href="javascript:void(0)"><fmt:message key="jdnt_timeline.placeholderTitle"/></a></h2>
                <p><fmt:message key="jdnt_timeline.placeholderBody"/></p><p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc id purus a ex bibendum sagittis sit amet vel quam. Fusce sodales fermentum dignissim. Cu...</p>
                <a class="btn-u btn-u-sm" href="javascript:void(0)"><fmt:message key="jdmix_buttonText.readmore"/></a>
            </div>
            <div class="timeline-footer">
                <ul class="list-unstyled list-inline blog-info">
                    <li><i class="fa fa-clock-o"></i> ${newsDate}</li>
                </ul>
            </div>
        </div>
    </li>


    <li class="timeline-inverted">
        <div class="timeline-badge primary"><i class="glyphicon glyphicon-record"></i></div>
        <div class="timeline-panel">
            <div class="timeline-heading">
                <img class="img-responsive" src="${url.currentModule}/img/background.jpg" alt="">
            </div>
            <div class="timeline-body text-justify">
                <h2><a href="javascript:void(0)"><fmt:message key="jdnt_timeline.placeholderTitle"/></a></h2>
                <p><fmt:message key="jdnt_timeline.placeholderBody"/></p><p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc id purus a ex bibendum sagittis sit amet vel quam. Fusce sodales fermentum dignissim. Curabitur sit amet risus non neque pellentesque pharetra pharetra at dolor. Donec fringilla nisl sed urna consectetur, at efficitur tortor pharetra. Nullam quis tellus sapien. Praesent mollis leo eu nisi feugiat posuere. Integer suscipit, est sit amet aliquam tincidunt, sapien enim commodo mauris, sit amet scelerisque purus felis et ligula. Nullam vel metus nisl. Nullam nec volutpat sem, ut pretium neque. Curabitur eu imperdiet velit. Curabitur vulputate mi nunc, ac pellentesque magna mattis sed. Curabitur in neque ac ligula finibus imperdiet gravida maximus massa. Nunc malesuada nisi sed justo imperdiet porttitor. Nullam non arcu velit. Morbi iaculis auctor erat eu porta. Sed suscipit a augue vitae malesuada.</p>
                <p>&nbsp;</p>
                <p></p>
            </div>
            <div class="timeline-footer">
                <ul class="list-unstyled list-inline blog-info">
                    <li><i class="fa fa-clock-o"></i> ${newsTomorrowDate}</li>
                </ul>
            </div>
        </div>
    </li>
    <li class="clearfix nofloat"></li>
