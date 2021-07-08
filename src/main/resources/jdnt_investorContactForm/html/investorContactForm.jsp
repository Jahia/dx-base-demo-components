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
<template:addResources type="css" resources="plugins/skyforms/sky-forms.css"/>
<template:addResources type="css" resources="plugins/skyforms/custom/custom-sky-forms.css"/>
<template:addResources type="javascript" resources="custom/inverstorContactForm.js"/>
<template:addResources type="javascript" resources="fa-v4-shims.min.js"/>
<template:addResources type="javascript" resources="fontawesome-all.min.js"/>

<c:set var="writeable" value="${currentResource.workspace eq 'live'}"/>
<c:if test='${not writeable}'>
    <c:set var="disabled" value='disabled="true"'/>
</c:if>

<div class="panel-group acc-v1" id="accordion-1">
    <div class="panel panel-default">
        <div class="panel-heading">
            <h4 class="panel-title">
                <%-- set componentId variable to in order to make each form panel unique on the page.
                These will be used to define collapsible panel div id and href anchor for the accordion controls --%>
                <c:set var="componentId" value="${currentNode.identifier}"/>
                <a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion-1"
                   href="#collapse-${componentId}">
                    <span class="tooltips" data-toggle="tooltip"
                          data-original-title="Please fill this form to keep informed"><fmt:message key="jdnt_investorContactForm.label"/></span>
                    <span class="pull-right"><i class="fa fa-caret-square-o-down"></i></span>
                </a>
            </h4>
        </div>
        <div id="collapse-${componentId}" class="panel-collapse collapse">
            <div class="panel-body">
                <%-- Tokenized Contact Form --%>
                <template:tokenizedForm>
                    <form action="<c:url value='${url.base}${currentNode.path}/*'/>" class="sky-form investor-contact-form"
                          id="investor-contact-${componentId}" method="post">
                        <div class="form-wrap">
                            <input type="hidden" name="jcrNodeType" value="jdnt:investorContact"/>
                            <input type="hidden" name="jcrRedirectTo"
                                   value="<c:url value='${url.base}${renderContext.mainResource.node.path}'/>"/>
                                <%-- Define the output format for the newly created node by default html or by jcrRedirectTo--%>
                            <input type="hidden" name="jcrNewNodeOutputFormat" value="html"/>
                            <jcr:nodeType name="jdnt:investorContact" var="investorContact"/>
                            <c:set var="propDefs" value="${investorContact.declaredPropertyDefinitionsAsMap}"/>
                            <header><fmt:message key="jdnt_investorContactForm.header"/></header>
                            <fieldset>
                                <section>
                                    <label class="input">
                                        <i class="icon-append fa fa-user"></i>
                                        <input type="text" name="firstname"
                                               placeholder="<fmt:message key="jdnt_investorContactForm.firstname"/>" ${disabled}>
                                        <b class="tooltip tooltip-bottom-right"><fmt:message
                                                key="jdnt_investorContactForm.firstname.tooltip"/></b>
                                    </label>
                                </section>

                                <section>
                                    <label class="input">
                                        <i class="icon-append fa fa-user"></i>
                                        <input type="text" name="lastname"
                                               placeholder="<fmt:message key="jdnt_investorContactForm.lastname"/>" ${disabled}>
                                        <b class="tooltip tooltip-bottom-right"><fmt:message
                                                key="jdnt_investorContactForm.lastname.tooltip"/></b>
                                    </label>
                                </section>

                                <section>
                                    <label class="input">
                                        <i class="icon-append fa fa-envelope"></i>
                                        <input type="email" name="email"
                                               placeholder="<fmt:message key="jdnt_investorContactForm.email"/>" ${disabled}>
                                        <b class="tooltip tooltip-bottom-right"><fmt:message
                                                key="jdnt_investorContactForm.email.tooltip"/></b>
                                    </label>
                                </section>

                                <section>
                                    <label class="input">
                                        <i class="icon-append fa fa-phone"></i>
                                        <input type="text" name="phone"
                                               placeholder="<fmt:message key="jdnt_investorContactForm.phone"></fmt:message>" ${disabled}>
                                        <b class="tooltip tooltip-bottom-right"><fmt:message
                                                key="jdnt_investorContactForm.phone.tooltip"/></b>
                                    </label>
                                </section>

                                <section>
                                    <label class="select">
                                        <select name="investorType" id="investorType" ${disabled}>
                                            <option value="0" selected="" disabled=""><fmt:message
                                                    key="jdnt_investorContactForm.investorType"/></option>
                                            <c:forEach items="${propDefs.investorType.valueConstraints}" var="valueOption">
                                                <option value="${valueOption}"><fmt:message
                                                        key="jdnt_investorContactForm.investorType.${valueOption}"/></option>
                                            </c:forEach>
                                        </select>
                                        <i></i>
                                    </label>
                                </section>

                                <section>
                                    <label class="select">
                                        <select name="contactReason" id="contactReason" ${disabled}>
                                            <option value="0" selected="" disabled=""><fmt:message
                                                    key="jdnt_investorContactForm.contactReason"/></option>
                                            <c:forEach items="${propDefs.contactReason.valueConstraints}" var="valueOption">
                                                <option value="${valueOption}"><fmt:message
                                                        key="jdnt_investorContactForm.contactReason.${valueOption}"/></option>
                                            </c:forEach>
                                        </select>
                                        <i></i>
                                    </label>
                                </section>

                                <section>
                                    <label class="label">
                                        <fmt:message key="jdnt_investorContactForm.subscription.label"/>
                                    </label>
                                    <c:forEach items="${propDefs.subscription.valueConstraints}" var="valueOption">
                                        <label class="radio">
                                            <input type="radio" name="subscription" ${disabled}
                                                   value="${valueOption}"><fmt:message
                                                key="jdnt_investorContactForm.subscription.${valueOption}"/>
                                            <i></i>
                                        </label>
                                    </c:forEach>
                                </section>
                            </fieldset>
                            <footer>
                                <button type="submit" class="btn-u investor-button" ${disabled}>Submit
                                </button>
                            </footer>
                        </div>
                        <div class="investor-saved" style="display: none">
                            <fmt:message key="jdnt_investorContactForm.submitted"/>
                        </div>
                    </form>
                </template:tokenizedForm>
                <%--/end Tokenized Contact Form --%>
            </div>
        </div>
    </div>
</div>