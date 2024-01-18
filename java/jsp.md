```
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ page import="mes.cmm.util.MberHelper" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="mesfn" uri="mestaglib" %>
<c:set var="nowdate" value="<%= new java.util.Date() %>"/>
<c:set var="fmtNow"><fmt:formatDate value="${nowdate}" pattern="yyyy-MM-dd HH시 mm분 ss초"/></c:set>
<c:set var="fmtNowYear"><fmt:formatDate value="${nowdate}" pattern="yyyy"/></c:set>
<c:set var="fmtNowDate"><fmt:formatDate value="${nowdate}" pattern="yyyy-MM-dd"/></c:set>

<script type="text/javascript">

	<%--시군구 코드의 구조적 한계로 인한 예외처리--%> 
	const excludeArr = ["all", "1613000", "6500000", "5690000"];

	window.onload = function() {

		/* 행정기관 검색 후 - 시군구 설정*/
		let optionNameF = "";
		const elementF = document.querySelector("#searchSehighInscdF");
		elementF.options.forEach(function(ele){
			if(ele.value == elementF.value) {
				optionNameF = ele.innerHTML;
			}
		});
		sfrndInfoSignguSelectBox({
			brtcInscd: "<c:out value="${searchVO.searchSehighInscdF }" />",
			signguTagName: "searchInscdF",
			signguInscd: "<c:out value="${searchVO.searchInscdF }" />",
			isFocus: false,
			callback: function(select) {
				if(!excludeArr.includes("<c:out value="${searchVO.searchSehighInscdF }" />")) {
 					select.options.add(new Option(optionNameF, "<c:out value="${searchVO.searchSehighInscdF }" />", false, "<c:out value="${searchVO.searchSehighInscdF }" />" == "<c:out value="${searchVO.searchInscdF }" />"));
				} 
			}
		});
		/* 행정기관 검색 후 - 시군구 설정*/
		
		
		/* 일자 제한 검색조건 파라미터 포맷 변경 : yyyymmdd -> yyyy-mm-dd */
		document.querySelector("#searchEndYmdD").value = getAddFormat("<c:out value="${searchVO.searchEndYmdD}"/>");
		document.querySelector("#searchEndYmdE").value = getAddFormat("<c:out value="${searchVO.searchEndYmdE}"/>");
		document.querySelector("#searchEndYmdF").value = getAddFormat("<c:out value="${searchVO.searchEndYmdF}"/>");
		//document.querySelector("#searchEndYmdG").value = getAddFormat("<c:out value="${searchVO.searchEndYmdG}"/>");
		//document.querySelector("#searchEndYmdH").value = getAddFormat("<c:out value="${searchVO.searchEndYmdH}"/>");
				
		//검색 후 자동 scroll 
		autoScroll();

	}


	//select 시군구 option에 시/도 단위 추가를 위해 커스텀
	function onchangeSearchSehighInscd(element, formName) {
		let optionName = "";
		element.options.forEach(function(ele){
			if(ele.value == element.value) {
				optionName = ele.innerHTML;
			}
		});
		
		sfrndInfoSignguSelectBox({
			brtcInscd: element.value, 
			signguTagName: 'searchInscd'+formName,
			callback: function(select) {
				if(!excludeArr.includes(element.value)) {
					select.options.add(new Option(optionName, element.value, false, "<c:out value="${searchVO.searchSehighInscdF }" />" == "<c:out value="${searchVO.searchInscdF }" />")); 
				}
			}
		});
	}

	
	function autoScroll() {
		<c:if test="${not empty formName}">
		document.querySelector("form[name=searchForm<c:out value="${formName}"/>]").scrollIntoView({behavior:'smooth', block:'center'});
		</c:if>
	}

	
	/* URL 매핑 */
	const urlMap = {
					"A" : "TotalMberStatusInfo.do",
					"B" : "MonthMberStatusInfo.do",
					"C" : "MberTypeStatusInfo.do",
					"D"	: "MonthLoginStatusInfo.do",
					"E" : "SysUseMberStatusInfo.do",
					"F" : "SfrndMberStatusInfo.do"				
					}

	const formNameList = ["A","B","C","D","E","F","G","H"];
	
	/* 엑셀다운로드 처리 */
	function excelDownload(formName, type){
		const form = document.querySelector("form[name=searchForm"+formName+"]");
		form.action = "<c:url value='/adm/frt/excelDownload'/>"+urlMap[formName];
		form.submit();
	}

	/* 검색 */
	function selectSearchList(formName) {
		const form = document.querySelector("form[name=searchForm"+formName+"]");
		formNameList.forEach(function(e) {
			if(formName != e) {
				const paramYear = document.querySelector("#searchYear"+e);
				const paramBgnDe = document.querySelector("#searchBgnDe"+e);
				const paramEndDe = document.querySelector("#searchEndDe"+e);
				const paramEndYmd = document.querySelector("#searchEndYmd"+e);
				if(!isNull(paramYear)) { form.appendChild(createFormParameter("searchYear"+e, paramYear.value)); }
				if(!isNull(paramBgnDe)) { form.appendChild(createFormParameter("searchBgnDe"+e, paramBgnDe.value)); }
				if(!isNull(paramEndDe)) { form.appendChild(createFormParameter("searchEndDe"+e, paramEndDe.value)); }
				if(!isNull(paramEndYmd)) { form.appendChild(createFormParameter("searchEndYmd"+e, paramEndYmd.value)); }
			}
		});

		
		const ele = createFormParameter("formName", formName);
		form.appendChild(ele);
		
		form.action = "<c:url value='/adm/frt/main.do'/>";
		form.submit();
	}

	function createFormParameter(name, value) {
		const ele = document.createElement("input");
		ele.name = name;
		ele.type = "hidden";
		ele.value = value;

		return ele;
	}
	
	/* 검색조건초기화 처리 */
	function resetCondition(formName){
		const form = document.querySelector("form[name=searchForm"+formName+"]");
		const searchObj = form.querySelectorAll("[name^=search]");
		
		for(let item of searchObj){
			if("INPUT" == item.tagName){
				if("text" == item.type || "hidden" == item.type){
					item.value = "";
				}else if("radio" == item.type || "checkbox" == item.type){
					item.checked = false;
				}
			}else if("SELECT" == item.tagName){
				item.value = "";
			}
		}
		
		selectSearchList(formName);
	}

	/** 검색시작년도 변경 시 callback */
	function changeStartYear(e, formName) {
		const startDate = e.date.getFullYear();
		const interval = <c:out value="${fmtNowYear}"/>-Number(startDate);

		$("#searchEndDe"+formName).datepicker("setStartDate", "-"+interval.toString() + "y");
	}

	/** 검색종료년도 변경 시 callback */
	function changeEndYear(e, formName) {
		const nowYear = <c:out value="${fmtNowYear}"/>;
		const endDate = e.date.getFullYear();
		const interval = nowYear-Number(endDate);

		const startDate = document.querySelector("#searchBgnDe"+formName).value;
		if(Number(startDate) > Number(endDate)) {
			document.querySelector("#searchBgnDe"+formName).value = endDate;
		}
		
		$("#searchBgnDe"+formName).datepicker("setEndDate", "-"+interval.toString() + "y");

		
		const limitDate = document.querySelector("#searchEndYmd"+formName);
		if(!isNull(limitDate)) {
			if(Number(interval) == 0) {
				$("#searchEndYmd"+formName).datepicker("setEndDate", "+0d");	
				$("#searchEndYmd"+formName).datepicker("setDate", "+0d");	
 				limitDate.value = "<c:out value="${fmtNowDate}"/>";
			} else {
				$("#searchEndYmd"+formName).datepicker("setEndDate", new Date(endDate+"-12-31"));
				$("#searchEndYmd"+formName).datepicker("setDate", endDate+"-12-31");
 				limitDate.value = endDate+"-12-31";
			}
		}
	}

</script>

<!-- 내용 시작 -->
<!-- <div class="content-wrapper" style="display:none;"> -->
<div class="content-wrapper">
	
	<form name="searchFormA" method="post"></form>
	
	<!-- 컨텐츠 행 시작 -->
	<div class="contents-row">
		<div class="portlet">
			<div class="portlet-body">
				<div class="portlet-body-hr">
					<h3 class="portlet-body-title">전체 사용자 현황</h3>
					<hr class="portlet-body-title-hr">
					<div class="form-inline row">
						<div class="input-group col-md-4 col-xs-4 col-sm-4">
							<div class="table-top-control">
								<div class="form-inline">
									<div class="input-group col-md-9 col-xs-9 col-sm-9 t-left">
									<h3 class="page-title-2depth"><span><c:out value="${fmtNow}"/> 기준</span></h3>
									</div>
									<div class="input-group col-md-3 col-xs-3 col-sm-3 t-right">
										<button type="button" class="btn dark" onclick="excelDownload('A');">엑셀</button>
									</div>
								</div>
							</div>
							<div class="table-scrollable marB0">
								<table class="table table-bordered">
									<caption>테이블 요약</caption>
									<colgroup>
										<col style="width:25%;">
										<col style="width:auto;">
									</colgroup>
									<tbody>
										<c:set var="totalMberStatTotal" value="${0}"/>
										<c:forEach var="totalMberStat" items="${totalMberStatus}" varStatus="status">
											<c:set var="totalMberStatTotal" value="${totalMberStatTotal+totalMberStat.cnt}"/>
										<tr>
											<th class="td-head" scope="rowgroup"><c:out value="${totalMberStat.mberStCdNm}"/></th>
											<td><fmt:formatNumber value="${totalMberStat.cnt}" pattern="###,###,###"/></td>
										</tr>
										</c:forEach>
										<tr>
											<th class="bold" scope="rowgroup">합계</th>
											<td class="font-bold"><fmt:formatNumber value="${totalMberStatTotal}" pattern="###,###,###"/></td>
										</tr>
									</tbody>
								</table>
							</div>
							<div class="table-bottom-control">
								<div class="form-inline">
									<div class="input-group col-md-9 col-xs-9 col-sm-9 t-left">
									<span>※ 현재 시점 기준 사용자 상태별 현황</span>
									</div>
									<div class="input-group col-md-3 col-xs-3 col-sm-3 t-right">
										<span>※ 단위(명)</span>
									</div>
								</div>
							</div>
						</div>
						<div class="input-group col-md-8 col-xs-8 col-sm-8">
							<!-- 차트 시작 -->
							<div id="chartdiv_pieChart" class="ac-chart ac-chart-pieChart" style="width:100%; height:250px;"><div style="width: 100%; height: 100%; position: relative;"><svg version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" role="group" style="width: 100%; height: 100%; overflow: visible;"><defs><clipPath id="id-46"><rect width="800" height="300"></rect></clipPath><clipPath id="id-71"></clipPath><filter id="filter-id-51" filterUnits="objectBoundingBox" width="200%" height="200%" x="-50%" y="-50%"><feGaussianBlur result="blurOut" in="SourceGraphic" stdDeviation="1.5"></feGaussianBlur><feOffset result="offsetBlur" dx="1" dy="1"></feOffset><feFlood flood-color="#000000" flood-opacity="0.5"></feFlood><feComposite in2="offsetBlur" operator="in"></feComposite><feMerge><feMergeNode></feMergeNode><feMergeNode in="SourceGraphic"></feMergeNode></feMerge></filter><filter id="filter-id-76" filterUnits="objectBoundingBox" width="200%" height="200%" x="-50%" y="-50%"><feGaussianBlur result="blurOut" in="SourceGraphic" stdDeviation="1.5"></feGaussianBlur><feOffset result="offsetBlur" dx="1" dy="1"></feOffset><feFlood flood-color="#000000" flood-opacity="0.5"></feFlood><feComposite in2="offsetBlur" operator="in"></feComposite><feMerge><feMergeNode></feMergeNode><feMergeNode in="SourceGraphic"></feMergeNode></feMerge></filter><filter id="filter-id-154" filterUnits="objectBoundingBox" width="130%" height="130%" x="-15%" y="-15%"></filter></defs><g><g fill="#ffffff" fill-opacity="0"><rect width="800" height="300"></rect></g><g><g role="region" clip-path="url(&quot;#id-46&quot;)" opacity="1" aria-label="Chart"><g><g><g><g><g><g transform="translate(400,130.5)"><g><g role="group" opacity="1" aria-label="Series"><g><g clip-path="url(&quot;#id-71&quot;)"><g></g></g><g></g><g><g><g stroke-opacity="1" fill="#dcd267" role="menuitem" focusable="true" tabindex="0" id="id-226" stroke="#dcd267" transform="translate(0,0)"><g><g fill="#a59e4d" stroke="#a59e4d" opacity="1"><path d=" M0,-92.8  L0,0  L0,-20  L0,-112.8  Z"></path></g><g fill="#a59e4d" stroke="#a59e4d" opacity="1"><path d=" M-81.1167,-78.42  A104.4,92.80000000000001,0,0,1,-75.5405,-84.0554 L-75.5405,-64.0554  A104.4,92.80000000000001,0,0,0,-81.1167,-58.42 L-81.1167,-78.42 z M-75.5405,-84.0554  A104.4,92.80000000000001,0,0,1,-69.4703,-89.272 L-69.4703,-69.272  A104.4,92.80000000000001,0,0,0,-75.5405,-64.0554 L-75.5405,-84.0554 z M-69.4703,-89.272  A104.4,92.80000000000001,0,0,1,-62.9457,-94.0354 L-62.9457,-74.0354  A104.4,92.80000000000001,0,0,0,-69.4703,-69.272 L-69.4703,-89.272 z M-62.9457,-94.0354  A104.4,92.80000000000001,0,0,1,-56.0094,-98.3146 L-56.0094,-78.3146  A104.4,92.80000000000001,0,0,0,-62.9457,-74.0354 L-62.9457,-94.0354 z M-56.0094,-98.3146  A104.4,92.80000000000001,0,0,1,-48.7068,-102.0816 L-48.7068,-82.0816  A104.4,92.80000000000001,0,0,0,-56.0094,-78.3146 L-56.0094,-98.3146 z M-48.7068,-102.0816  A104.4,92.80000000000001,0,0,1,-41.0856,-105.3117 L-41.0856,-85.3117  A104.4,92.80000000000001,0,0,0,-48.7068,-82.0816 L-48.7068,-102.0816 z M-41.0856,-105.3117  A104.4,92.80000000000001,0,0,1,-33.1956,-107.9839 L-33.1956,-87.9839  A104.4,92.80000000000001,0,0,0,-41.0856,-85.3117 L-41.0856,-105.3117 z M-33.1956,-107.9839  A104.4,92.80000000000001,0,0,1,-25.0886,-110.0806 L-25.0886,-90.0806  A104.4,92.80000000000001,0,0,0,-33.1956,-87.9839 L-33.1956,-107.9839 z M-25.0886,-110.0806  A104.4,92.80000000000001,0,0,1,-16.8175,-111.5881 L-16.8175,-91.5881  A104.4,92.80000000000001,0,0,0,-25.0886,-90.0806 L-25.0886,-110.0806 z M-16.8175,-111.5881  A104.4,92.80000000000001,0,0,1,-8.4363,-112.4965 L-8.4363,-92.4965  A104.4,92.80000000000001,0,0,0,-16.8175,-91.5881 L-16.8175,-111.5881 z M-8.4363,-112.4965  A104.4,92.80000000000001,0,0,1,0,-112.8 L0,-92.8  A104.4,92.80000000000001,0,0,0,-8.4363,-92.4965 L-8.4363,-112.4965 z M0,-20  L0,0  L0,-20 z M0,-20  L0,0  L0,-20 z M0,-20  L0,0  L0,-20 z M0,-20  L0,0  L0,-20 z M0,-20  L0,0  L0,-20 z M0,-20  L0,0  L0,-20 z M0,-20  L0,0  L0,-20 z M0,-20  L0,0  L0,-20 z M0,-20  L0,0  L0,-20 z M0,-20  L0,0  L0,-20 z M0,-20  L0,0  L0,-20 z"></path></g><g transform="translate(0,-20)"><path d=" M0,0  L-81.1167,-58.42  a104.4,92.80000000000001,0,0,1,81.1167,-34.38 L0,0 "></path></g><g></g><g fill="#a59e4d" stroke="#a59e4d" opacity="1"><path d=" M0,0  L-81.1167,-58.42  L-81.1167,-78.42  L0,-20  Z"></path></g></g></g><g stroke-opacity="1" fill="#dc6967" role="menuitem" focusable="true" tabindex="0" id="id-190" stroke="#dc6967" transform="translate(0,0)"><g><g fill="#a54f4d" stroke="#a54f4d" opacity="1"><path d=" M-81.1167,-58.42  L0,0  L0,-20  L-81.1167,-78.42  Z"></path></g><g fill="#a54f4d" stroke="#a54f4d" opacity="1"><path d=" M-96.225,15.9985  L-96.225,35.9985  A104.4,92.80000000000001,0,0,1,-99.252,28.7813 L-99.252,8.7813  A104.4,92.80000000000001,0,0,0,-96.225,15.9985z M-99.252,8.7813  L-99.252,28.7813  A104.4,92.80000000000001,0,0,1,-101.5953,21.3659 L-101.5953,1.3659  A104.4,92.80000000000001,0,0,0,-99.252,8.7813z M-101.5953,1.3659  L-101.5953,21.3659  A104.4,92.80000000000001,0,0,1,-103.2387,13.8033 L-103.2387,-6.1967  A104.4,92.80000000000001,0,0,0,-101.5953,1.3659z M-103.2387,-6.1967  L-103.2387,13.8033  A104.4,92.80000000000001,0,0,1,-104.1708,6.1456 L-104.1708,-13.8544  A104.4,92.80000000000001,0,0,0,-103.2387,-6.1967z M-104.1708,-13.8544  A104.4,92.80000000000001,0,0,1,-104.3854,-21.5545 L-104.3854,-1.5545  A104.4,92.80000000000001,0,0,0,-104.1708,6.1456 L-104.1708,-13.8544 z M-104.3854,-21.5545  A104.4,92.80000000000001,0,0,1,-103.8808,-29.2438 L-103.8808,-9.2438  A104.4,92.80000000000001,0,0,0,-104.3854,-1.5545 L-104.3854,-21.5545 z M-103.8808,-29.2438  A104.4,92.80000000000001,0,0,1,-102.6606,-36.8694 L-102.6606,-16.8694  A104.4,92.80000000000001,0,0,0,-103.8808,-9.2438 L-103.8808,-29.2438 z M-102.6606,-36.8694  A104.4,92.80000000000001,0,0,1,-100.7331,-44.3789 L-100.7331,-24.3789  A104.4,92.80000000000001,0,0,0,-102.6606,-16.8694 L-102.6606,-36.8694 z M-100.7331,-44.3789  A104.4,92.80000000000001,0,0,1,-98.1117,-51.7204 L-98.1117,-31.7204  A104.4,92.80000000000001,0,0,0,-100.7331,-24.3789 L-100.7331,-44.3789 z M-98.1117,-51.7204  A104.4,92.80000000000001,0,0,1,-94.8144,-58.8433 L-94.8144,-38.8433  A104.4,92.80000000000001,0,0,0,-98.1117,-31.7204 L-98.1117,-51.7204 z M-94.8144,-58.8433  A104.4,92.80000000000001,0,0,1,-90.864,-65.6987 L-90.864,-45.6987  A104.4,92.80000000000001,0,0,0,-94.8144,-38.8433 L-94.8144,-58.8433 z M-90.864,-65.6987  A104.4,92.80000000000001,0,0,1,-86.2876,-72.2393 L-86.2876,-52.2393  A104.4,92.80000000000001,0,0,0,-90.864,-45.6987 L-90.864,-65.6987 z M-86.2876,-72.2393  A104.4,92.80000000000001,0,0,1,-81.1167,-78.42 L-81.1167,-58.42  A104.4,92.80000000000001,0,0,0,-86.2876,-52.2393 L-86.2876,-72.2393 z M0,-20  L0,0  L0,-20 z M0,-20  L0,0  L0,-20 z M0,-20  L0,0  L0,-20 z M0,-20  L0,0  L0,-20 z M0,-20  L0,0  L0,-20 z M0,-20  L0,0  L0,-20 z M0,-20  L0,0  L0,-20 z M0,-20  L0,0  L0,-20 z M0,-20  L0,0  L0,-20 z M0,-20  L0,0  L0,-20 z M0,-20  L0,0  L0,-20 z M0,-20  L0,0  L0,-20 z M0,-20  L0,0  L0,-20 z"></path></g><g transform="translate(0,-20)"><path d=" M0,0  L-96.225,35.9985  a104.4,92.80000000000001,0,0,1,15.1083,-94.4184 L0,0 "></path></g><g></g><g fill="#a54f4d" stroke="#a54f4d" opacity="1"><path d=" M0,0  L-96.225,35.9985  L-96.225,15.9985  L0,-20  Z"></path></g></g></g><g stroke-opacity="1" fill="#67b7dc" role="menuitem" focusable="true" tabindex="0" id="id-117" stroke="#67b7dc" transform="translate(0,0)"><g><g fill="#4d89a5" stroke="#4d89a5" opacity="1"><path d=" M0,0  L0,-92.8  L0,-112.8  L0,-20  Z"></path></g><g fill="#4d89a5" stroke="#4d89a5" opacity="1"><path d=" M0,-112.8  A104.4,92.80000000000001,0,0,1,9.0603,-112.4499 L9.0603,-92.4499  A104.4,92.80000000000001,0,0,0,0,-92.8 L0,-112.8 z M9.0603,-112.4499  A104.4,92.80000000000001,0,0,1,18.0523,-111.4021 L18.0523,-91.4021  A104.4,92.80000000000001,0,0,0,9.0603,-92.4499 L9.0603,-112.4499 z M18.0523,-111.4021  A104.4,92.80000000000001,0,0,1,26.908,-109.6647 L26.908,-89.6647  A104.4,92.80000000000001,0,0,0,18.0523,-91.4021 L18.0523,-111.4021 z M26.908,-109.6647  A104.4,92.80000000000001,0,0,1,35.5607,-107.2507 L35.5607,-87.2507  A104.4,92.80000000000001,0,0,0,26.908,-89.6647 L26.908,-109.6647 z M35.5607,-107.2507  A104.4,92.80000000000001,0,0,1,43.9451,-104.1783 L43.9451,-84.1783  A104.4,92.80000000000001,0,0,0,35.5607,-87.2507 L35.5607,-107.2507 z M43.9451,-104.1783  A104.4,92.80000000000001,0,0,1,51.9978,-100.4707 L51.9978,-80.4707  A104.4,92.80000000000001,0,0,0,43.9451,-84.1783 L43.9451,-104.1783 z M51.9978,-100.4707  A104.4,92.80000000000001,0,0,1,59.6582,-96.1558 L59.6582,-76.1558  A104.4,92.80000000000001,0,0,0,51.9978,-80.4707 L51.9978,-100.4707 z M59.6582,-96.1558  A104.4,92.80000000000001,0,0,1,66.8684,-91.2664 L66.8684,-71.2664  A104.4,92.80000000000001,0,0,0,59.6582,-76.1558 L59.6582,-96.1558 z M66.8684,-91.2664  A104.4,92.80000000000001,0,0,1,73.5741,-85.8391 L73.5741,-65.8391  A104.4,92.80000000000001,0,0,0,66.8684,-71.2664 L66.8684,-91.2664 z M73.5741,-85.8391  A104.4,92.80000000000001,0,0,1,79.7245,-79.9151 L79.7245,-59.9151  A104.4,92.80000000000001,0,0,0,73.5741,-65.8391 L73.5741,-85.8391 z M79.7245,-79.9151  A104.4,92.80000000000001,0,0,1,85.2734,-73.5389 L85.2734,-53.5389  A104.4,92.80000000000001,0,0,0,79.7245,-59.9151 L79.7245,-79.9151 z M85.2734,-73.5389  A104.4,92.80000000000001,0,0,1,90.1788,-66.7587 L90.1788,-46.7587  A104.4,92.80000000000001,0,0,0,85.2734,-53.5389 L85.2734,-73.5389 z M90.1788,-66.7587  A104.4,92.80000000000001,0,0,1,94.4038,-59.6258 L94.4038,-39.6258  A104.4,92.80000000000001,0,0,0,90.1788,-46.7587 L90.1788,-66.7587 z M94.4038,-59.6258  A104.4,92.80000000000001,0,0,1,97.9164,-52.1938 L97.9164,-32.1938  A104.4,92.80000000000001,0,0,0,94.4038,-39.6258 L94.4038,-59.6258 z M97.9164,-52.1938  A104.4,92.80000000000001,0,0,1,100.6901,-44.5188 L100.6901,-24.5188  A104.4,92.80000000000001,0,0,0,97.9164,-32.1938 L97.9164,-52.1938 z M100.6901,-44.5188  A104.4,92.80000000000001,0,0,1,102.7041,-36.6589 L102.7041,-16.6589  A104.4,92.80000000000001,0,0,0,100.6901,-24.5188 L100.6901,-44.5188 z M102.7041,-36.6589  A104.4,92.80000000000001,0,0,1,103.943,-28.6733 L103.943,-8.6733  A104.4,92.80000000000001,0,0,0,102.7041,-16.6589 L102.7041,-36.6589 z M103.943,-28.6733  A104.4,92.80000000000001,0,0,1,104.3977,-20.6222 L104.3977,-0.6222  A104.4,92.80000000000001,0,0,0,103.943,-8.6733 L103.943,-28.6733 z M104.3977,-20.6222  L104.3977,-0.6222  A104.4,92.80000000000001,0,0,1,104.0645,7.4336 L104.0645,-12.5664  A104.4,92.80000000000001,0,0,0,104.3977,-20.6222z M104.0645,-12.5664  L104.0645,7.4336  A104.4,92.80000000000001,0,0,1,102.9461,15.4333 L102.9461,-4.5667  A104.4,92.80000000000001,0,0,0,104.0645,-12.5664z M102.9461,-4.5667  L102.9461,15.4333  A104.4,92.80000000000001,0,0,1,101.0509,23.3165 L101.0509,3.3165  A104.4,92.80000000000001,0,0,0,102.9461,-4.5667z M101.0509,3.3165  L101.0509,23.3165  A104.4,92.80000000000001,0,0,1,98.3932,31.0238 L98.3932,11.0238  A104.4,92.80000000000001,0,0,0,101.0509,3.3165z M98.3932,11.0238  L98.3932,31.0238  A104.4,92.80000000000001,0,0,1,94.993,38.497 L94.993,18.497  A104.4,92.80000000000001,0,0,0,98.3932,11.0238z M94.993,18.497  L94.993,38.497  A104.4,92.80000000000001,0,0,1,90.8761,45.6797 L90.8761,25.6797  A104.4,92.80000000000001,0,0,0,94.993,18.497z M90.8761,25.6797  L90.8761,45.6797  A104.4,92.80000000000001,0,0,1,86.0734,52.5177 L86.0734,32.5177  A104.4,92.80000000000001,0,0,0,90.8761,25.6797z M86.0734,32.5177  L86.0734,52.5177  A104.4,92.80000000000001,0,0,1,80.6212,58.9595 L80.6212,38.9595  A104.4,92.80000000000001,0,0,0,86.0734,32.5177z M80.6212,38.9595  L80.6212,58.9595  A104.4,92.80000000000001,0,0,1,74.5606,64.9563 L74.5606,44.9563  A104.4,92.80000000000001,0,0,0,80.6212,38.9595z M74.5606,44.9563  L74.5606,64.9563  A104.4,92.80000000000001,0,0,1,67.9374,70.463 L67.9374,50.463  A104.4,92.80000000000001,0,0,0,74.5606,44.9563z M67.9374,50.463  L67.9374,70.463  A104.4,92.80000000000001,0,0,1,60.8016,75.4379 L60.8016,55.4379  A104.4,92.80000000000001,0,0,0,67.9374,50.463z M60.8016,55.4379  L60.8016,75.4379  A104.4,92.80000000000001,0,0,1,53.207,79.8437 L53.207,59.8437  A104.4,92.80000000000001,0,0,0,60.8016,55.4379z M53.207,59.8437  L53.207,79.8437  A104.4,92.80000000000001,0,0,1,45.2109,83.6469 L45.2109,63.6469  A104.4,92.80000000000001,0,0,0,53.207,59.8437z M0,-20  L0,0  L0,-20 z M0,-20  L0,0  L0,-20 z M0,-20  L0,0  L0,-20 z M0,-20  L0,0  L0,-20 z M0,-20  L0,0  L0,-20 z M0,-20  L0,0  L0,-20 z M0,-20  L0,0  L0,-20 z M0,-20  L0,0  L0,-20 z M0,-20  L0,0  L0,-20 z M0,-20  L0,0  L0,-20 z M0,-20  L0,0  L0,-20 z M0,-20  L0,0  L0,-20 z M0,-20  L0,0  L0,-20 z M0,-20  L0,0  L0,-20 z M0,-20  L0,0  L0,-20 z M0,-20  L0,0  L0,-20 z M0,-20  L0,0  L0,-20 z M0,-20  L0,0  L0,-20 z M0,-20  L0,0  L0,-20 z M0,-20  L0,0  L0,-20 z M0,-20  L0,0  L0,-20 z M0,-20  L0,0  L0,-20 z M0,-20  L0,0  L0,-20 z M0,-20  L0,0  L0,-20 z M0,-20  L0,0  L0,-20 z M0,-20  L0,0  L0,-20 z M0,-20  L0,0  L0,-20 z M0,-20  L0,0  L0,-20 z M0,-20  L0,0  L0,-20 z M0,-20  L0,0  L0,-20 z M0,-20  L0,0  L0,-20 z"></path></g><g transform="translate(0,-20)"><path d=" M0,0  L0,-92.8  a104.4,92.80000000000001,0,0,1,45.2109,176.4469 L0,0 "></path></g><g></g><g fill="#4d89a5" stroke="#4d89a5" opacity="1"><path d=" M45.2109,83.6469  L0,0  L0,-20  L45.2109,63.6469  Z"></path></g></g></g><g stroke-opacity="1" fill="#8067dc" role="menuitem" focusable="true" tabindex="0" id="id-154" stroke="#8067dc" transform="translate(0,0)" style="outline: none;"><g><g fill="#604da5" stroke="#604da5" opacity="1"><path d=" M-96.225,35.9985  L0,0  L0,-20  L-96.225,15.9985  Z"></path></g><g fill="#604da5" stroke="#604da5" opacity="1"><path d=" M0,0  L45.2109,83.6469  L45.2109,63.6469  L0,-20  Z"></path></g><g fill="#604da5" stroke="#604da5" opacity="1"><path d=" M45.2109,63.6469  L45.2109,83.6469  A104.4,92.80000000000001,0,0,1,37.0313,86.7659 L37.0313,66.7659  A104.4,92.80000000000001,0,0,0,45.2109,63.6469z M37.0313,66.7659  L37.0313,86.7659  A104.4,92.80000000000001,0,0,1,28.5826,89.2543 L28.5826,69.2543  A104.4,92.80000000000001,0,0,0,37.0313,66.7659z M28.5826,69.2543  L28.5826,89.2543  A104.4,92.80000000000001,0,0,1,19.9261,91.094 L19.9261,71.094  A104.4,92.80000000000001,0,0,0,28.5826,69.2543z M19.9261,71.094  L19.9261,91.094  A104.4,92.80000000000001,0,0,1,11.1247,92.2716 L11.1247,72.2716  A104.4,92.80000000000001,0,0,0,19.9261,71.094z M11.1247,72.2716  L11.1247,92.2716  A104.4,92.80000000000001,0,0,1,2.2426,92.7786 L2.2426,72.7786  A104.4,92.80000000000001,0,0,0,11.1247,72.2716z M2.2426,72.7786  L2.2426,92.7786  A104.4,92.80000000000001,0,0,1,-6.6559,92.6112 L-6.6559,72.6112  A104.4,92.80000000000001,0,0,0,2.2426,72.7786z M-6.6559,72.6112  L-6.6559,92.6112  A104.4,92.80000000000001,0,0,1,-15.506,91.7707 L-15.506,71.7707  A104.4,92.80000000000001,0,0,0,-6.6559,72.6112z M-15.506,71.7707  L-15.506,91.7707  A104.4,92.80000000000001,0,0,1,-24.2434,90.2632 L-24.2434,70.2632  A104.4,92.80000000000001,0,0,0,-15.506,71.7707z M-24.2434,70.2632  L-24.2434,90.2632  A104.4,92.80000000000001,0,0,1,-32.8046,88.0997 L-32.8046,68.0997  A104.4,92.80000000000001,0,0,0,-24.2434,70.2632z M-32.8046,68.0997  L-32.8046,88.0997  A104.4,92.80000000000001,0,0,1,-41.1273,85.2958 L-41.1273,65.2958  A104.4,92.80000000000001,0,0,0,-32.8046,68.0997z M-41.1273,65.2958  L-41.1273,85.2958  A104.4,92.80000000000001,0,0,1,-49.1512,81.872 L-49.1512,61.872  A104.4,92.80000000000001,0,0,0,-41.1273,65.2958z M-49.1512,61.872  L-49.1512,81.872  A104.4,92.80000000000001,0,0,1,-56.8178,77.8532 L-56.8178,57.8532  A104.4,92.80000000000001,0,0,0,-49.1512,61.872z M-56.8178,57.8532  L-56.8178,77.8532  A104.4,92.80000000000001,0,0,1,-64.0714,73.2685 L-64.0714,53.2685  A104.4,92.80000000000001,0,0,0,-56.8178,57.8532z M-64.0714,53.2685  L-64.0714,73.2685  A104.4,92.80000000000001,0,0,1,-70.8594,68.1512 L-70.8594,48.1512  A104.4,92.80000000000001,0,0,0,-64.0714,53.2685z M-70.8594,48.1512  L-70.8594,68.1512  A104.4,92.80000000000001,0,0,1,-77.1323,62.5386 L-77.1323,42.5386  A104.4,92.80000000000001,0,0,0,-70.8594,48.1512z M-77.1323,42.5386  L-77.1323,62.5386  A104.4,92.80000000000001,0,0,1,-82.8447,56.4715 L-82.8447,36.4715  A104.4,92.80000000000001,0,0,0,-77.1323,42.5386z M-82.8447,36.4715  L-82.8447,56.4715  A104.4,92.80000000000001,0,0,1,-87.9549,49.994 L-87.9549,29.994  A104.4,92.80000000000001,0,0,0,-82.8447,36.4715z M-87.9549,29.994  L-87.9549,49.994  A104.4,92.80000000000001,0,0,1,-92.4258,43.153 L-92.4258,23.153  A104.4,92.80000000000001,0,0,0,-87.9549,29.994z M-92.4258,23.153  L-92.4258,43.153  A104.4,92.80000000000001,0,0,1,-96.225,35.9985 L-96.225,15.9985  A104.4,92.80000000000001,0,0,0,-92.4258,23.153z M0,-20  L0,0  L0,-20 z M0,-20  L0,0  L0,-20 z M0,-20  L0,0  L0,-20 z M0,-20  L0,0  L0,-20 z M0,-20  L0,0  L0,-20 z M0,-20  L0,0  L0,-20 z M0,-20  L0,0  L0,-20 z M0,-20  L0,0  L0,-20 z M0,-20  L0,0  L0,-20 z M0,-20  L0,0  L0,-20 z M0,-20  L0,0  L0,-20 z M0,-20  L0,0  L0,-20 z M0,-20  L0,0  L0,-20 z M0,-20  L0,0  L0,-20 z M0,-20  L0,0  L0,-20 z M0,-20  L0,0  L0,-20 z M0,-20  L0,0  L0,-20 z M0,-20  L0,0  L0,-20 z M0,-20  L0,0  L0,-20 z"></path></g><g transform="translate(0,-20)"><path d=" M0,0  L45.2109,83.6469  a104.4,92.80000000000001,0,0,1,-141.4359,-47.6484 L0,0 "></path></g><g></g></g></g></g></g><g><g><g fill-opacity="0" stroke-opacity="0.2" stroke="#000000" stroke-width="1"><polyline points="101.79315033264001,-40.6083199264,109.62,-25.676,115.62,-25.676"></polyline></g><g fill-opacity="0" stroke-opacity="0.2" stroke="#000000" stroke-width="1"><polyline points="-36.99959156964,66.77663780544002,-109.62,108.115,-115.62,108.115"></polyline></g><g fill-opacity="0" stroke-opacity="0.2" stroke="#000000" stroke-width="1"><polyline points="-103.35971295468,-33.0678680832,-109.62,-16.281,-115.62,-16.281"></polyline></g><g fill-opacity="0" stroke-opacity="0.2" stroke="#000000" stroke-width="1"><polyline points="-44.93292546816001,-103.76518482912,-109.62,-104.363,-115.62,-104.363"></polyline></g></g></g><g><g><g fill="#000000" aria-label="서울: 42.9%" transform="translate(115.62,-25.676)"><g transform="translate(5,-8)" style="user-select: none;"><text x="0" y="16" dy="-4.32"><tspan>서울: 42.9%</tspan></text></g></g><g fill="#000000" aria-label="대구: 25.8%" transform="translate(-115.62,108.115)"><g transform="translate(-89,-8)" style="user-select: none;"><text x="0" y="16" dy="-4.32"><tspan>대구: 25.8%</tspan></text></g></g><g fill="#000000" aria-label="대전: 17.2%" transform="translate(-115.62,-16.281)"><g transform="translate(-89,-8)" style="user-select: none;"><text x="0" y="16" dy="-4.32"><tspan>대전: 17.2%</tspan></text></g></g><g fill="#000000" aria-label="부산: 14.2%" transform="translate(-115.62,-104.363)"><g transform="translate(-89,-8)" style="user-select: none;"><text x="0" y="16" dy="-4.32"><tspan>부산: 14.2%</tspan></text></g></g></g></g></g></g></g></g><g transform="translate(400,150)"><g><g><g></g></g></g></g></g></g><g role="group" aria-label="Legend" transform="translate(0,261)"><g><g focusable="true" tabindex="0" role="switch" aria-controls="id-117" aria-labelledby="id-117" aria-checked="true" transform="translate(130,0)" style="cursor: pointer;"><g fill="#ffffff" fill-opacity="0"><rect width="120" height="39"></rect></g><g transform="translate(0,8)"><g style="pointer-events: none;"><g fill="#ffffff" fill-opacity="0" stroke-opacity="0"><rect width="23" height="23"></rect></g><g><g stroke-opacity="1" fill="#67b7dc" stroke="#67b7dc"><path d="M3,0 L20,0 a3,3 0 0 1 3,3 L23,20 a3,3 0 0 1 -3,3 L3,23 a3,3 0 0 1 -3,-3 L0,3 a3,3 0 0 1 3,-3 Z"></path></g></g></g><g fill="#000000" aria-label="서울" style="pointer-events: none;" transform="translate(28,3.5)"><g style="user-select: none;"><text x="0" y="16" overflow="hidden" dy="-4.32"><tspan>서울</tspan></text></g></g><g fill="#000000" aria-label="%" style="pointer-events: none;" transform="translate(65,3.5)"><g style="user-select: none;"><text x="50" y="16" dy="-4.32" text-anchor="end"><tspan>42.9%</tspan></text></g></g></g></g><g focusable="true" tabindex="0" role="switch" aria-controls="id-154" aria-labelledby="id-154" aria-checked="true" transform="translate(270,0)" style="cursor: pointer;"><g fill="#ffffff" fill-opacity="0"><rect width="120" height="39"></rect></g><g transform="translate(0,8)"><g style="pointer-events: none;"><g fill="#ffffff" fill-opacity="0" stroke-opacity="0"><rect width="23" height="23"></rect></g><g><g stroke-opacity="1" fill="#8067dc" stroke="#8067dc"><path d="M3,0 L20,0 a3,3 0 0 1 3,3 L23,20 a3,3 0 0 1 -3,3 L3,23 a3,3 0 0 1 -3,-3 L0,3 a3,3 0 0 1 3,-3 Z"></path></g></g></g><g fill="#000000" aria-label="대구" style="pointer-events: none;" transform="translate(28,3.5)"><g style="user-select: none;"><text x="0" y="16" overflow="hidden" dy="-4.32"><tspan>대구</tspan></text></g></g><g fill="#000000" aria-label="%" style="pointer-events: none;" transform="translate(65,3.5)"><g style="user-select: none;"><text x="50" y="16" dy="-4.32" text-anchor="end"><tspan>25.8%</tspan></text></g></g></g></g><g focusable="true" tabindex="0" role="switch" aria-controls="id-190" aria-labelledby="id-190" aria-checked="true" transform="translate(410,0)" style="cursor: pointer;"><g fill="#ffffff" fill-opacity="0"><rect width="120" height="39"></rect></g><g transform="translate(0,8)"><g style="pointer-events: none;"><g fill="#ffffff" fill-opacity="0" stroke-opacity="0"><rect width="23" height="23"></rect></g><g><g stroke-opacity="1" fill="#dc6967" stroke="#dc6967"><path d="M3,0 L20,0 a3,3 0 0 1 3,3 L23,20 a3,3 0 0 1 -3,3 L3,23 a3,3 0 0 1 -3,-3 L0,3 a3,3 0 0 1 3,-3 Z"></path></g></g></g><g fill="#000000" aria-label="대전" style="pointer-events: none;" transform="translate(28,3.5)"><g style="user-select: none;"><text x="0" y="16" overflow="hidden" dy="-4.32"><tspan>대전</tspan></text></g></g><g fill="#000000" aria-label="%" style="pointer-events: none;" transform="translate(65,3.5)"><g style="user-select: none;"><text x="50" y="16" dy="-4.32" text-anchor="end"><tspan>17.2%</tspan></text></g></g></g></g><g focusable="true" tabindex="0" role="switch" aria-controls="id-226" aria-labelledby="id-226" aria-checked="true" transform="translate(550,0)" style="cursor: pointer;"><g fill="#ffffff" fill-opacity="0"><rect width="120" height="39"></rect></g><g transform="translate(0,8)"><g style="pointer-events: none;"><g fill="#ffffff" fill-opacity="0" stroke-opacity="0"><rect width="23" height="23"></rect></g><g><g stroke-opacity="1" fill="#dcd267" stroke="#dcd267"><path d="M3,0 L20,0 a3,3 0 0 1 3,3 L23,20 a3,3 0 0 1 -3,3 L3,23 a3,3 0 0 1 -3,-3 L0,3 a3,3 0 0 1 3,-3 Z"></path></g></g></g><g fill="#000000" aria-label="부산" style="pointer-events: none;" transform="translate(28,3.5)"><g style="user-select: none;"><text x="0" y="16" overflow="hidden" dy="-4.32"><tspan>부산</tspan></text></g></g><g fill="#000000" aria-label="%" style="pointer-events: none;" transform="translate(65,3.5)"><g style="user-select: none;"><text x="50" y="16" dy="-4.32" text-anchor="end"><tspan>14.2%</tspan></text></g></g></g></g></g></g></g></g></g></g><g><g><g role="tooltip" visibility="hidden" opacity="0"><g fill="#ffffff" fill-opacity="0.9" stroke-width="1" stroke-opacity="1" stroke="#ffffff" filter="url(&quot;#filter-id-51&quot;)" style="pointer-events: none;" transform="translate(0,6)"><path d="M3,0 L3,0 L0,-6 L13,0 L21,0 a3,3 0 0 1 3,3 L24,8 a3,3 0 0 1 -3,3 L3,11 a3,3 0 0 1 -3,-3 L0,3 a3,3 0 0 1 3,-3"></path></g><g><g fill="#ffffff" style="pointer-events: none;" transform="translate(12,6)"><g transform="translate(0,7)" display="none"></g></g></g></g><g visibility="hidden" style="pointer-events: none;" display="none"><g fill="#ffffff" opacity="1"><rect width="800" height="300"></rect></g><g><g transform="translate(400,150)"><g><g stroke-opacity="1" fill="#f3f3f3" fill-opacity="0.8"><g><g><path d=" M53,0  a53,53,0,0,1,-106,0 a53,53,0,0,1,106,0 M42,0  a42,42,0,0,0,-84,0 a42,42,0,0,0,84,0 L42,0 "></path></g></g></g><g stroke-opacity="1" fill="#000000" fill-opacity="0.2"><g><g><path d=" M50,0  a50,50,0,0,1,-100,0 a50,50,0,0,1,100,0 M45,0  a45,45,0,0,0,-90,0 a45,45,0,0,0,90,0 L45,0 "></path></g></g></g><g fill="#000000" fill-opacity="0.4"><g transform="translate(-18.5,-8)" style="user-select: none;"><text x="18.5px" y="16" dy="-4.32" text-anchor="middle"><tspan>100%</tspan></text></g></g></g></g></g></g><g role="tooltip" opacity="0" aria-describedby="id-117" transform="translate(452.6924,97.7931)" aria-hidden="true" visibility="hidden"><g fill="#67b7dc" fill-opacity="0.9" stroke-width="1" stroke-opacity="1" stroke="#ffffff" filter="url(&quot;#filter-id-76&quot;)" style="pointer-events: none;" transform="translate(-82.5,-35)"><path d="M3,0 L162,0 a3,3 0 0 1 3,3 L165,26 a3,3 0 0 1 -3,3 L162,29 L87.5,29 L82.5,35 L77.5,29 L3,29 a3,3 0 0 1 -3,-3 L0,3 a3,3 0 0 1 3,-3"></path></g><g><g fill="#000000" style="pointer-events: none;" transform="translate(0,-35)"><g transform="translate(-70.5,7)" style="user-select: none;"><text x="0" y="18" dy="-4.86"><tspan>서울: 42.9% (501.9)</tspan></text></g></g></g></g></g></g></g></g></svg></div>
							</div>
							<div class="table-bottom-control marT10">
								<div class="form-inline">
									<div class="input-group col-md-12 col-xs-12 col-sm-12 t-center">
										<span>※ 색 아이콘을 클릭하여 차트에 포함/제외 할 수 있습니다.</span>
									</div>
								</div>
							</div>
							<script>
								am4core.useTheme(am4themes_animated);

								const chartColorMap = {
														"1":"#67b7dc",
														"2":"#dc6967",
														"3":"#dc67ce",
														"4":"#dcd267",
														"5":"#7ddc67",
														"6":"#8067dc"
													}
								
								var chart = am4core.create("chartdiv_pieChart", am4charts.PieChart3D);
								chart.hiddenState.properties.opacity = 0; // this creates initial fade-in
								
								chart.data = [
									<c:forEach var="totalMberStat" items="${totalMberStatus}" varStatus="status">
									{
										"country": "<c:out value="${totalMberStat.mberStCdNm}"/>",
										"litres": <c:out value="${totalMberStat.cnt}"/>,
										"color": am4core.color(chartColorMap["<c:out value="${status.count}"/>"])
									}
									<c:if test="${not status.last}">,</c:if>
									</c:forEach>
								];
		
								var pieSeries = chart.series.push(new am4charts.PieSeries3D());
								pieSeries.dataFields.value = "litres";
								pieSeries.dataFields.category = "country";
								pieSeries.slices.template.propertyFields.fill = "color";
		
								chart.legend = new am4charts.Legend();
							</script>
							<!-- 차트 끝 -->
						</div>
					</div>
	
				</div>
			</div>
		</div>
	</div>
	<!-- 컨텐츠 행 끝 -->
	<!-- 컨텐츠 행 시작 -->
	<div class="contents-row">
		<div class="portlet">
			<div class="portlet-body">
				<div class="portlet-body-hr">
					<h3 class="portlet-body-title">월별 사용자 상태 현황</h3>
					<hr class="portlet-body-title-hr">
					<form name="searchFormB" method="post">
						<table class="search-panel table table-bordered">
							<caption>월별 사용자 상태 현황 검색조건</caption>
							
							<colgroup>
								<col style="width: 10%;">
								<col style="width: auto;">						
							</colgroup>
							
							<tbody>
								<tr>
									<th class="td-head" scope="row">
										<label class="input-label-none" for="searchYearB">검색연도</label>검색연도
									</th>
									<td>
										<!--input id명칭과 for가 동일해야함 (웹접근성)-->
										<label class="input-label-none" for="searchYearB">label명</label>
										<div class="input-group input-icon date year-picker">
											<i class="fa fa-calendar"></i>
											<input type="text" id="searchYearB" name="searchYearB" title="년도" class="form-control" placeholder="년도를 선택하세요." value="<c:out value="${searchVO.searchYearB}"/>">
										</div>
										<script>       
											$('#searchYearB').datepicker({
												format: 'yyyy',
												viewMode: "years", 
												minViewMode: 'years',
												autoclose:true,
												endDate:'+0y'
											});
										</script>
									</td>
<!-- 									<td> -->
<!-- 										<div class="form-inline"> -->
<!-- 											input id명칭과 for가 동일해야함 (웹접근성) -->
<!-- 											<label class="input-label-none" for="searchYearB">검색년도입력</label> -->
											
<!-- 											<div class="input-group date date-picker" data-date-format="yyyy" data-date-viewmode="years"> -->
<!-- 												<input id="searchYearB" name="searchYearB" title="검색시작년도 입력" class="form-control" readonly="readonly" type="text" value=""><span class="input-group-btn"> -->
<!-- 													<button class="btn dark" type="button"> -->
<!-- 														<span class="ir">검색시작년도 달력 선택</span> -->
<!-- 														<i class="fa fa-calendar"></i> -->
<!-- 													</button> -->
<!-- 												</span> -->
<!-- 											</div> -->
<!-- 										</div> -->
<!-- 									</td> -->
								</tr>
							</tbody>
						</table>
					</form>
					<div class="table-bottom-control">
						<button type="button" class="btn btn-primary" onclick="selectSearchList('B');" title="월별 사용자 상태 현황 검색버튼">검색</button>
						<button type="button" class="btn dark" onclick="resetCondition('B');" title="월별 사용자 상태 현황 검색조건초기화버튼">초기화</button>
					</div>
					
					<div class="table-scrollable marT20 marB0">
						<table class="table table-bordered">
							<caption>테이블 요약</caption>
							<colgroup>
								<col style="width:8%;">
								<col style="width:10%;">
								<col style="width:auto;">
								<col style="width:auto;">
								<col style="width:auto;">
								<col style="width:auto;">
								<col style="width:auto;">
								<col style="width:auto;">
								<col style="width:auto;">
								<col style="width:auto;">
								<col style="width:auto;">
								<col style="width:auto;">
								<col style="width:auto;">
								<col style="width:auto;">
<%-- 								<col style="width:auto;"> --%>
							</colgroup>
							<thead>
								<tr>
									<th scope="col">연도</th>
									<th scope="col">유형</th>
									<th scope="col">1월</th>
									<th scope="col">2월</th>
									<th scope="col">3월</th>
									<th scope="col">4월</th>
									<th scope="col">5월</th>
									<th scope="col">6월</th>
									<th scope="col">7월</th>
									<th scope="col">8월</th>
									<th scope="col">9월</th>
									<th scope="col">10월</th>
									<th scope="col">11월</th>
									<th scope="col">12월</th>
<!-- 									<th scope="col">합계</th> -->
								</tr>
							</thead>
							<tbody>
								<c:forEach var="monthMberStat" items="${monthMberStatus}" varStatus="status">
									<tr>
										<c:if test="${status.count eq 1}"><td rowspan="7" class="textR font-bold t-center"><c:out value="${searchVO.searchYearB}"/></td></c:if>
										<td class="<c:out value="${monthMberStat.mberStCd eq 'total' ? 'textB ' : ''}"/>font-bold t-center"><c:out value="${monthMberStat.mberStCdNm}"/></td>
										<td class="<c:out value="${monthMberStat.mberStCd eq 'total' ? 'font-bold' : ''}"/>"><fmt:formatNumber value="${monthMberStat.m1}" pattern="###,###,###"/></td>
										<td class="<c:out value="${monthMberStat.mberStCd eq 'total' ? 'font-bold' : ''}"/>"><fmt:formatNumber value="${monthMberStat.m2}"  pattern="###,###,###"/></td>
										<td class="<c:out value="${monthMberStat.mberStCd eq 'total' ? 'font-bold' : ''}"/>"><fmt:formatNumber value="${monthMberStat.m3}"  pattern="###,###,###"/></td>
										<td class="<c:out value="${monthMberStat.mberStCd eq 'total' ? 'font-bold' : ''}"/>"><fmt:formatNumber value="${monthMberStat.m4}"  pattern="###,###,###"/></td>
										<td class="<c:out value="${monthMberStat.mberStCd eq 'total' ? 'font-bold' : ''}"/>"><fmt:formatNumber value="${monthMberStat.m5}"  pattern="###,###,###"/></td>
										<td class="<c:out value="${monthMberStat.mberStCd eq 'total' ? 'font-bold' : ''}"/>"><fmt:formatNumber value="${monthMberStat.m6}"  pattern="###,###,###"/></td>
										<td class="<c:out value="${monthMberStat.mberStCd eq 'total' ? 'font-bold' : ''}"/>"><fmt:formatNumber value="${monthMberStat.m7}"  pattern="###,###,###"/></td>
										<td class="<c:out value="${monthMberStat.mberStCd eq 'total' ? 'font-bold' : ''}"/>"><fmt:formatNumber value="${monthMberStat.m8}"  pattern="###,###,###"/></td>
										<td class="<c:out value="${monthMberStat.mberStCd eq 'total' ? 'font-bold' : ''}"/>"><fmt:formatNumber value="${monthMberStat.m9}"  pattern="###,###,###"/></td>
										<td class="<c:out value="${monthMberStat.mberStCd eq 'total' ? 'font-bold' : ''}"/>"><fmt:formatNumber value="${monthMberStat.m10}" pattern="###,###,###"/></td>
										<td class="<c:out value="${monthMberStat.mberStCd eq 'total' ? 'font-bold' : ''}"/>"><fmt:formatNumber value="${monthMberStat.m11}" pattern="###,###,###"/></td>
										<td class="<c:out value="${monthMberStat.mberStCd eq 'total' ? 'font-bold' : ''}"/>"><fmt:formatNumber value="${monthMberStat.m12}" pattern="###,###,###"/></td>
<%-- 										<td class="<c:out value="${monthMberStat.mberStCd eq 'total' ? 'textR ' : ''}"/>font-bold"><fmt:formatNumber value="${monthMberStat.total}" pattern="###,###,###"/></td> --%>
									</tr>
								</c:forEach>
								<c:if test="${fn:length(monthMberStatus) eq 0}">
									<tr>
										<td colspan="14" class="t-center"><spring:message code="common.nodata.msg" /></td><!-- 글이 없는 경우 -->
									</tr>
								</c:if>
							</tbody>
						</table>
					</div>
					<div class="table-bottom-control">
						<div class="form-inline">
							<div class="input-group col-md-10 col-xs-10 col-sm-10 t-left">
							<span>※ 월별 사용자 상태 현황</span>
							<span>※ 매 월 1일 기준으로 집계</span>
							</div>
							<div class="input-group col-md-2 col-xs-2 col-sm-2 t-right">
								<span>※ 단위(명)</span>
							</div>
						</div>
					</div>
					<div class="table-bottom-control marT20">
						<button type="button" class="btn dark" title="엑셀다운로드버튼" onclick="excelDownload('B');">엑셀</button>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- 컨텐츠 행 끝 -->
	
	<!-- 컨텐츠 행 시작 -->
	<div class="contents-row">
		<div class="portlet">
			<div class="portlet-body">
				<div class="portlet-body-hr">
					<h3 class="portlet-body-title">사용자 유형 현황</h3>
					<hr class="portlet-body-title-hr">
					<form name="searchFormC" method="post">
					</form>
					
					<div class="table-scrollable marT20 marB0">
						<table id="mberTypeStatus" class="table table-bordered">
							<caption>사용자 유형 현황</caption>
							<colgroup>
								<c:forEach begin="0" end="${fn:length(mberTypeStatus['mberTyCdList'])}">
									<col style="width:auto;">
								</c:forEach>
							</colgroup>
							<thead>
								<tr>
									<th scope="col" colspan="<c:out value="${mberTypeStatus['cvplCnt']}"/>">민원웹포털</th>
									<th scope="col" colspan="<c:out value="${mberTypeStatus['administCnt']}"/>">행정시스템</th>
								</tr>
								<tr>
									<c:forEach var="mberTyCdInfo" items="${mberTypeStatus['mberTyCdList']}" varStatus="status">
										<th scope="col">
											<c:out value="${mberTyCdInfo.mberTyCdNm}"/>
											<c:if test="${mberTyCdInfo.mberTyCdDc != '' && mberTyCdInfo.mberTyCdDc != null}">
												<br/>
												(<c:out value="${mberTyCdInfo.mberTyCdDc}"/>)
											</c:if>
										</th>	
									</c:forEach>
								</tr>
							</thead>
							
							<tbody>
								<tr>
									<!-- 민원웹포털 -->
									<c:forEach var="mberTyCdInfo" items="${mberTypeStatus['mberTyCdList']}" varStatus="status">
										<c:if test="${mberTypeStatus['mberTySttList'][0][mberTyCdInfo.mberTyCd] != null}">
											<td scope="col">
												<fmt:formatNumber value="${mberTypeStatus['mberTySttList'][0][mberTyCdInfo.mberTyCd]}" pattern="###,###,###"/>
											</td>
										</c:if>
									</c:forEach>
									
									<!-- 행정시스템 -->
									<c:forEach var="mberTyCdInfo" items="${mberTypeStatus['mberTyCdList']}" varStatus="status">
										<c:if test="${mberTypeStatus['mberTySttList'][1][mberTyCdInfo.mberTyCd] != null}">
											<td scope="col">
												<fmt:formatNumber value="${mberTypeStatus['mberTySttList'][1][mberTyCdInfo.mberTyCd]}" pattern="###,###,###"/>
											</td>
										</c:if>
									</c:forEach>
								</tr>
							</tbody>
						</table>
					</div>
					<div class="table-bottom-control">
						<div class="form-inline">
							<div class="input-group col-md-10 col-xs-10 col-sm-10 t-left">
							<span>※ 사용자 유형(업무유형) 별 현황</span>
							</div>
							<div class="input-group col-md-2 col-xs-2 col-sm-2 t-right">
								<span>※ 단위(명)</span>
							</div>
						</div>
					</div>
					<div class="table-bottom-control marT20">
						<button type="button" class="btn dark" title="엑셀다운로드버튼" onclick="excelDownload('C');">엑셀</button>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- 컨텐츠 행 끝 -->
	
	<!-- 컨텐츠 행 시작 -->
	<div class="contents-row">
		<div class="portlet">
			<div class="portlet-body">
				<div class="portlet-body-hr">
					<h3 class="portlet-body-title">월별 시스템 접속자수 현황</h3>
					<hr class="portlet-body-title-hr">
					<form name="searchFormD" method="post">
						<table class="search-panel table table-bordered">
							<caption>월별시스템접속자수현황 검색조건</caption>
							
							<colgroup>
								<col style="width: 10%;">
								<col style="width: auto;">						
							</colgroup>
							
							<tbody>
								<tr>
									<th class="td-head" scope="row">
										<label class="input-label-none" for="searchDeCnd">검색연도</label>검색연도
									</th>
									
									<td>
										<div class="form-inline">
											
											
											<!--input id명칭과 for가 동일해야함 (웹접근성)-->
											<label class="input-label-none" for="searchBgnDeD">검색시작년도</label>
											<div class="input-group input-icon date year-picker">
												<i class="fa fa-calendar"></i>
												<input type="text" id="searchBgnDeD" name="searchBgnDeD" title="년도" class="form-control" placeholder="년도를 선택하세요." value="<c:out value="${searchVO.searchBgnDeD}"/>">
											</div>
											<script>       
												$('#searchBgnDeD').datepicker({
													format: 'yyyy',
													viewMode: "years", 
													minViewMode: 'years',
													autoclose:true,
													endDate:'-0y'
												}).on('changeDate', function(e) {
													changeStartYear(e,"D");
												});
											</script>
											
											<span> ~ </span>
											
											<!--input id명칭과 for가 동일해야함 (웹접근성)-->
											<label class="input-label-none" for="searchEndDeD">검색종료년도</label>
											<div class="input-group input-icon date year-picker">
												<i class="fa fa-calendar"></i>
												<input type="text" id="searchEndDeD" name="searchEndDeD" title="년도" class="form-control" placeholder="년도를 선택하세요." value="<c:out value="${searchVO.searchEndDeD}"/>">
											</div>
											<script>       
												$('#searchEndDeD').datepicker({
													format: 'yyyy',
													viewMode: "years", 
													minViewMode: 'years',
													autoclose:true,
													endDate:'+0y'
												}).on('changeDate', function(e) {
													changeEndYear(e,"D");
												});
											</script>
											<span class="marL30"> 날짜제한 : </span>
											
											<!--input id명칭과 for가 동일해야함 (웹접근성)-->
											<label class="input-label-none" for="searchEndYmdD">label명</label>
											<div class="input-group input-icon date year-picker">
												<i class="fa fa-calendar"></i>
												<input type="text" id="searchEndYmdD" name="searchEndYmdD" value="<c:out value="${searchVO.searchEndYmdD}"/>" title="공지기한" class="form-control">
											</div>
											<script>       
												$('#searchEndYmdD').datepicker({
													format: 'yyyy-mm-dd',
													viewMode: "days", 
													minViewMode: 'days',
													autoclose:true,
													endDate:'+0d',
													immediateUpdates: true
												});											
											</script>
											<span> 까지 </span>
										</div>
									</td>
								</tr>
							</tbody>
						</table>
					</form>
					<div class="table-bottom-control">
						<button type="button" class="btn btn-primary" onclick="selectSearchList('D');" title="월별시스템접속자수현황 검색버튼">검색</button>
						<button type="button" class="btn dark" onclick="resetCondition('D');" title="월별시스템접속자수현황 검색조건초기화버튼">초기화</button>
					</div>
					
					<div class="table-scrollable marT20 marB0">
						<table class="table table-bordered">
							<caption>월별시스템접속자수현황</caption>
							<colgroup>
								<col style="width:8%;">
								<col style="width:10%;">
								<col style="width:6%;">
								<col style="width:6%;">
								<col style="width:6%;">
								<col style="width:6%;">
								<col style="width:6%;">
								<col style="width:6%;">
								<col style="width:6%;">
								<col style="width:6%;">
								<col style="width:6%;">
								<col style="width:6%;">
								<col style="width:6%;">
								<col style="width:6%;">
								<col style="width:10%;">
							</colgroup>
							<thead>
								<tr>
									<th scope="col">연도</th>
									<th scope="col">유형</th>
									<th scope="col">1월</th>
									<th scope="col">2월</th>
									<th scope="col">3월</th>
									<th scope="col">4월</th>
									<th scope="col">5월</th>
									<th scope="col">6월</th>
									<th scope="col">7월</th>
									<th scope="col">8월</th>
									<th scope="col">9월</th>
									<th scope="col">10월</th>
									<th scope="col">11월</th>
									<th scope="col">12월</th>
									<th scope="col">연간 접속자수</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="monthLoginStat" items="${monthLoginStatus}" varStatus="status">
									<tr>
										<!-- 연도 -->
										<c:if test="${status.count%2 == 1}">
											<c:choose>
												<c:when test="${status.count%2 == 1 && monthLoginStat.year != '0000'}">
													<td class="textR font-bold t-center" rowspan="2"><c:out value="${monthLoginStat.year}"/></td>
												</c:when>
												<c:otherwise>
													<td class="textB font-bold t-center" colspan="2">소계</td>
												</c:otherwise>
											</c:choose>
										</c:if>
										
										<!-- 유형 -->
										<c:if test="${monthLoginStat.year != '0000'}">
											<td class="font-bold t-center">
												<c:out value="${monthLoginStat.stType}"/>
											</td>
										</c:if>
										
										<!-- 이하 월&합계 -->
										<td><fmt:formatNumber value="${monthLoginStat.m1}" pattern="###,###,###"/></td>
										<td><fmt:formatNumber value="${monthLoginStat.m2}"  pattern="###,###,###"/></td>
										<td><fmt:formatNumber value="${monthLoginStat.m3}"  pattern="###,###,###"/></td>
										<td><fmt:formatNumber value="${monthLoginStat.m4}"  pattern="###,###,###"/></td>
										<td><fmt:formatNumber value="${monthLoginStat.m5}"  pattern="###,###,###"/></td>
										<td><fmt:formatNumber value="${monthLoginStat.m6}"  pattern="###,###,###"/></td>
										<td><fmt:formatNumber value="${monthLoginStat.m7}"  pattern="###,###,###"/></td>
										<td><fmt:formatNumber value="${monthLoginStat.m8}"  pattern="###,###,###"/></td>
										<td><fmt:formatNumber value="${monthLoginStat.m9}"  pattern="###,###,###"/></td>
										<td><fmt:formatNumber value="${monthLoginStat.m10}" pattern="###,###,###"/></td>
										<td><fmt:formatNumber value="${monthLoginStat.m11}" pattern="###,###,###"/></td>
										<td><fmt:formatNumber value="${monthLoginStat.m12}" pattern="###,###,###"/></td>
										<td class="font-bold"><fmt:formatNumber value="${monthLoginStat.total}" pattern="###,###,###"/></td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
					<div class="table-bottom-control">
						<div class="form-inline">
							<div class="input-group col-md-10 col-xs-10 col-sm-10 t-left">
							<span>※ 시스템 사용자가 로그인을 성공한 횟수. 한 유저가 로그인을 2번 했을 경우 접속자수는 2 증가로 산정</span>
							</div>
							<div class="input-group col-md-2 col-xs-2 col-sm-2 t-right">
								<span>※ 단위(명)</span>
							</div>
						</div>
					</div>
					<div class="table-bottom-control marT20">
						<button type="button" class="btn dark" title="엑셀다운로드버튼" onclick="excelDownload('D');">엑셀</button>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- 컨텐츠 행 끝 -->
	
	<!-- 컨텐츠 행 시작 -->
	<div class="contents-row">
		<div class="portlet">
			<div class="portlet-body">
				<div class="portlet-body-hr">
					<h3 class="portlet-body-title">월별 시스템 이용자수 현황</h3>
					<hr class="portlet-body-title-hr">

					<form name="searchFormE" method="post">
						<table class="search-panel table table-bordered">
							<caption>월별 시스템 이용자수 현황 검색조건</caption>
							
							<colgroup>
								<col style="width: 10%;">
								<col style="width: auto;">						
							</colgroup>
							
							<tbody>
								<tr>
									<th class="td-head" scope="row">
										<label class="input-label-none" for="searchDeCnd">검색연도</label>검색연도
									</th>
									
									<td>
										<div class="form-inline">
											
											
											<!--input id명칭과 for가 동일해야함 (웹접근성)-->
											<label class="input-label-none" for="searchBgnDeE">label명</label>
											<div class="input-group input-icon date year-picker">
												<i class="fa fa-calendar"></i>
												<input type="text" id="searchBgnDeE" name="searchBgnDeE" title="년도" class="form-control" placeholder="년도를 선택하세요." value="<c:out value="${searchVO.searchBgnDeE}"/>">
											</div>
											<script>       
												$('#searchBgnDeE').datepicker({
													format: 'yyyy',
													viewMode: "years", 
													minViewMode: 'years',
													autoclose:true,
													endDate:'-0y'
												}).on('changeDate', function(e) {
													changeStartYear(e,"E");
												});
											</script>
											
											<span> ~ </span>
											
											<!--input id명칭과 for가 동일해야함 (웹접근성)-->
											<label class="input-label-none" for="searchEndDeE">label명</label>
											<div class="input-group input-icon date year-picker">
												<i class="fa fa-calendar"></i>
												<input type="text" id="searchEndDeE" name="searchEndDeE" title="년도" class="form-control" placeholder="년도를 선택하세요." value="<c:out value="${searchVO.searchEndDeE}"/>">
											</div>
											<script>       
												$('#searchEndDeE').datepicker({
													format: 'yyyy',
													viewMode: "years", 
													minViewMode: 'years',
													autoclose:true,
													endDate:'+0y'
												}).on('changeDate', function(e) {
													changeEndYear(e,"E");
												});
											</script>
											
											<span class="marL30"> 날짜제한 : </span>
											
											<!--input id명칭과 for가 동일해야함 (웹접근성)-->
											<label class="input-label-none" for="searchEndYmdE">label명</label>
											<div class="input-group input-icon date year-picker">
												<i class="fa fa-calendar"></i>
												<input type="text" id="searchEndYmdE" name="searchEndYmdE" value="<c:out value="${searchVO.searchEndYmdE}"/>" title="공지기한" class="form-control">
											</div>
											<script>       
												$('#searchEndYmdE').datepicker({
													format: 'yyyy-mm-dd',
													viewMode: "days", 
													minViewMode: 'days',
													autoclose:true,
													endDate:'+0d',
													immediateUpdates: true
												});											
											</script>
											<span> 까지 </span>
										</div>
									</td>
								</tr>
							</tbody>
						</table>
					</form>
					<div class="table-bottom-control">
						<button type="button" class="btn btn-primary" onclick="selectSearchList('E');" title="공개자료실 검색버튼">검색</button>
						<button type="button" class="btn dark" onclick="resetCondition('E');" title="공개자료실 검색조건초기화버튼">초기화</button>
					</div>
					
					<div class="table-scrollable marT20 marB0">
						<table class="table table-bordered">
							<caption>테이블 요약</caption>
							<colgroup>
								<col style="width:8%;">
								<col style="width:10%;">
								<col style="width:auto;">
								<col style="width:auto;">
								<col style="width:auto;">
								<col style="width:auto;">
								<col style="width:auto;">
								<col style="width:auto;">
								<col style="width:auto;">
								<col style="width:auto;">
								<col style="width:auto;">
								<col style="width:auto;">
								<col style="width:auto;">
								<col style="width:auto;">
								<col style="width:auto;">
								<col style="width:auto;">
							</colgroup>
							<thead>
								<tr>
									<th scope="col">연도</th>
									<th scope="col">유형</th>
									<th scope="col">1월</th>
									<th scope="col">2월</th>
									<th scope="col">3월</th>
									<th scope="col">4월</th>
									<th scope="col">5월</th>
									<th scope="col">6월</th>
									<th scope="col">7월</th>
									<th scope="col">8월</th>
									<th scope="col">9월</th>
									<th scope="col">10월</th>
									<th scope="col">11월</th>
									<th scope="col">12월</th>
									<th scope="col">연간 이용자수</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="sysUseMberStat" items="${sysUseMberStatus}" varStatus="status">
									<tr>
										<c:if test="${status.count%2 eq 1}">
										<td class="textR font-bold t-center" rowspan="2"><c:out value="${sysUseMberStat.year}"/></td>
										</c:if>
										<td class="font-bold t-center"><c:out value="${sysUseMberStat.stType}"/></td>
										<td><fmt:formatNumber value="${sysUseMberStat.m1}" pattern="###,###,###"/></td>
										<td><fmt:formatNumber value="${sysUseMberStat.m2}"  pattern="###,###,###"/></td>
										<td><fmt:formatNumber value="${sysUseMberStat.m3}"  pattern="###,###,###"/></td>
										<td><fmt:formatNumber value="${sysUseMberStat.m4}"  pattern="###,###,###"/></td>
										<td><fmt:formatNumber value="${sysUseMberStat.m5}"  pattern="###,###,###"/></td>
										<td><fmt:formatNumber value="${sysUseMberStat.m6}"  pattern="###,###,###"/></td>
										<td><fmt:formatNumber value="${sysUseMberStat.m7}"  pattern="###,###,###"/></td>
										<td><fmt:formatNumber value="${sysUseMberStat.m8}"  pattern="###,###,###"/></td>
										<td><fmt:formatNumber value="${sysUseMberStat.m9}"  pattern="###,###,###"/></td>
										<td><fmt:formatNumber value="${sysUseMberStat.m10}" pattern="###,###,###"/></td>
										<td><fmt:formatNumber value="${sysUseMberStat.m11}" pattern="###,###,###"/></td>
										<td><fmt:formatNumber value="${sysUseMberStat.m12}" pattern="###,###,###"/></td>
										<td class="font-bold"><fmt:formatNumber value="${sysUseMberStat.total}" pattern="###,###,###"/></td>
									</tr>
								</c:forEach>
								
								
							</tbody>
						</table>
					</div>
					<div class="table-bottom-control">
						<div class="form-inline">
							<div class="input-group col-md-10 col-xs-10 col-sm-10 t-left">
							<span>※ 한 사용자가 특정 월에 1번을 초과하여 접속했을 경우에도 해당 월에 해당 사용자에 의한 이용자수 증가는 1명으로 산정</span>
							<br/>
							<span>※ 연간 이용자수는 해당 년도에 시스템을 사용한 사용자의 수를 뜻함. 한 사용자가 1번을 초과하여 접속했을 경우에도 해당 연도의 이용자수 증가는 1명으로 산정</span>
							</div>
							<div class="input-group col-md-2 col-xs-2 col-sm-2 t-right">
								<span>※ 단위(명)</span>
							</div>
						</div>
					</div>
					<div class="table-bottom-control marT20">
						<button type="button" class="btn dark" title="엑셀다운로드버튼" onclick="excelDownload('E');">엑셀</button>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- 컨텐츠 행 끝 -->

	<!-- 컨텐츠 행 시작 -->
	<div class="contents-row">
		<div class="portlet">
			<div class="portlet-body">
				<div class="portlet-body-hr">
					<h3 class="portlet-body-title">기관별 시스템 사용자가입 현황</h3>
					<hr class="portlet-body-title-hr">

					<form name="searchFormF" method="post">
						<table class="search-panel table table-bordered">
							<caption>기관별 시스템 사용자가입 현황 검색조건</caption>
							
							<colgroup>
								<col style="width: 10%;">
								<col style="width: auto;">						
								<col style="width: 10%;">						
								<col style="width: auto;">						
							</colgroup>
							
							<tbody>
								<tr>
									<th class="td-head" scope="row">
										<label class="input-label-none" for="searchDeCnd">검색연도</label>검색연도
									</th>
									
									<td>
										<!--input id명칭과 for가 동일해야함 (웹접근성)-->
									
										
										<div class="form-inline">
											
											<!--input id명칭과 for가 동일해야함 (웹접근성)-->
											<label class="input-label-none" for="searchBgnDeF">label명</label>
											<div class="input-group input-icon date year-picker">
												<i class="fa fa-calendar"></i>
												<input type="text" id="searchBgnDeF" name="searchBgnDeF" title="년도" class="form-control" placeholder="년도를 선택하세요." value="<c:out value="${searchVO.searchBgnDeF}"/>">
											</div>
											<script>       
												$('#searchBgnDeF').datepicker({
													format: 'yyyy',
													viewMode: "years", 
													minViewMode: 'years',
													autoclose:true,
													endDate:'-0y'
												}).on('changeDate', function(e) {
													changeStartYear(e,"F");
												});
											</script>
											
											<span> ~ </span>
											
											<!--input id명칭과 for가 동일해야함 (웹접근성)-->
											<label class="input-label-none" for="searchEndDeF">label명</label>
											<div class="input-group input-icon date year-picker">
												<i class="fa fa-calendar"></i>
												<input type="text" id="searchEndDeF" name="searchEndDeF" title="년도" class="form-control" placeholder="년도를 선택하세요." value="<c:out value="${searchVO.searchEndDeF}"/>">
											</div>
											<script>       
												$('#searchEndDeF').datepicker({
													format: 'yyyy',
													viewMode: "years", 
													minViewMode: 'years',
													autoclose:true,
													endDate:'+0y'
												}).on('changeDate', function(e) {
													changeEndYear(e,"F");
												});
											</script>
											
											<span class="marL30"> 날짜제한 : </span>
											
											<!--input id명칭과 for가 동일해야함 (웹접근성)-->
											<label class="input-label-none" for="searchEndYmdF">label명</label>
											<div class="input-group input-icon date year-picker">
												<i class="fa fa-calendar"></i>
												<input type="text" id="searchEndYmdF" name="searchEndYmdF" value="<c:out value="${searchVO.searchEndYmdF}"/>" title="공지기한" class="form-control">
												
											</div>
											<script>       
												$('#searchEndYmdF').datepicker({
													format: 'yyyy-mm-dd',
													viewMode: "days", 
													minViewMode: 'days',
													autoclose:true,
													endDate:'+0d',
													immediateUpdates: true
												});											
											</script>
											<span> 까지 </span>
										</div>
									</td>
									
									<th class="td-head" scope="row">
										<label class="input-label-none" for="searchDeCnd">기관검색</label>기관검색
									</th>
									<td>
										<div class="form-inline">
											<div class="input-group col-md-4 col-xs-4 col-sm-4">
												<span class="input-group-label">
													<label class="input-label-none" for="searchSehighInscdF">광역시도 ${smCselect }</label>
												</span>
												<select id="searchSehighInscdF" name="searchSehighInscdF" title="광역시도 ${smCselect }" class="bs-select form-control" onchange="onchangeSearchSehighInscd(this, 'F');">
													<option value="all">광역시도 ${smCselect }</option>
													<option value="1613000" <c:out value="${'1613000' eq searchVO.searchSehighInscdF ? 'selected':'' }"/>>국토교통부</option>
													<c:forEach var="brtc" items="${brtcList }" varStatus="status">
													<option value="<c:out value="${brtc.inscd}"/>" <c:out value="${brtc.inscd eq searchVO.searchSehighInscdF ? 'selected':'' }"/>><c:out value="${brtc.lowestInsttNm}"/></option>
													</c:forEach>
												</select>
											</div>
											<div class="input-group col-md-8 col-xs-8 col-sm-8">
												<span class="input-group-label">
													<label class="input-label-none" for="searchInscdF">시군구 ${smCselect }</label>
												</span>
												<select id="searchInscdF" name="searchInscdF" title="시군구 ${smCselect }" class="bs-select form-control">
													<option value="">시군구 ${smCselect }</option>
												</select>
											</div>
										</div>
									</td>
								</tr>
							</tbody>
						</table>
					</form>
					<div class="table-bottom-control">
						<button type="button" class="btn btn-primary" onclick="selectSearchList('F');" title="기관별 시스템 사용자가입 현황 검색버튼">검색</button>
						<button type="button" class="btn dark" onclick="resetCondition('F');" title="기관별 시스템 사용자가입 현황  검색조건초기화버튼">초기화</button>
					</div>
					
					<div class="table-scrollable marT20 marB0">
						<table class="table table-bordered">
							<caption>테이블 요약</caption>
							<colgroup>
								<col style="width:8%;">
								<col style="width:10%;">
								<col style="width:10%;">
								<col style="width:auto;">
								<col style="width:auto;">
								<col style="width:auto;">
								<col style="width:auto;">
								<col style="width:auto;">
								<col style="width:auto;">
								<col style="width:auto;">
								<col style="width:auto;">
								<col style="width:auto;">
								<col style="width:auto;">
								<col style="width:auto;">
								<col style="width:auto;">
								<col style="width:auto;">
								<col style="width:auto;">
							</colgroup>
							<thead>
								<tr>
									<th scope="col">연도</th>
									<th scope="col">시/도</th>
									<th scope="col">시/군/구</th>
									<th scope="col">1월</th>
									<th scope="col">2월</th>
									<th scope="col">3월</th>
									<th scope="col">4월</th>
									<th scope="col">5월</th>
									<th scope="col">6월</th>
									<th scope="col">7월</th>
									<th scope="col">8월</th>
									<th scope="col">9월</th>
									<th scope="col">10월</th>
									<th scope="col">11월</th>
									<th scope="col">12월</th>
									<th scope="col">합계</th>
								</tr>
							</thead>
							<tbody>
								<%-- 초기세팅 --%>
								<c:set var="beforeYearF" value=""/>
								<c:set var="beforeSehighInscdNmF" value=""/>
								<c:set var="endMergeF" value="0"/>
								<%-- 초기세팅 --%>
								
								<c:forEach var="sfrndMberStat" items="${sfrndMberStatus}" varStatus="status">
									<%-- 초기세팅 --%>
									<c:set var="nextYearF" value="${sfrndMberStat.year}"/>
									<c:set var="nextSehighInscdNmCntF" value="0"/>
									<c:set var="endMergeF" value="${endMergeF-1}"/>
									<%-- 초기세팅 --%>
										
									<%-- 시군구 merge 세팅 --%>
									<c:if test="${endMergeF < 1}">
										<c:set var="beforeSehighInscdNmF" value="${sfrndMberStat.sehighInscdNm}"/>
										<c:forEach var="sfrndMberStatSub" items="${sfrndMberStatus}" varStatus="subStatus">
											<c:if test="${sfrndMberStat.year eq sfrndMberStatSub.year and sfrndMberStat.sehighInscdNm eq sfrndMberStatSub.sehighInscdNm}">
												<c:set var="nextSehighInscdNmF" value="${sfrndMberStatSub.sehighInscdNm}"/>
												<c:if test="${nextSehighInscdNmF eq beforeSehighInscdNmF}">
													<c:set var="nextSehighInscdNmCntF" value="${nextSehighInscdNmCntF+1}"/>
												</c:if>
												<c:set var="beforeSehighInscdNmF" value="${sfrndMberStatSub.sehighInscdNm}"/>
											</c:if>
										</c:forEach>													
									</c:if>
									<%-- 시군구 merge 세팅 --%>
									
									<tr>
										<c:if test="${beforeYearF ne nextYearF}">
										<td class="textR font-bold t-center" rowspan="<c:out value="${yearMergeF}"/>"><c:out value="${sfrndMberStat.year}"/></td> <!-- 연도 -->
										</c:if>
										
										<c:if test="${endMergeF < 1}">
										<c:set var="endMergeF" value="${nextSehighInscdNmCntF}"/>
										<td class="font-bold t-center" rowspan="<c:out value="${nextSehighInscdNmCntF}"/>"><c:out value="${sfrndMberStat.sehighInscdNm}"/></td> <!-- 시도 -->
										</c:if>
										
										<td class="font-bold t-center"><c:out value="${sfrndMberStat.inscdNm}"/></td> <!-- 시군구 -->										
										<td><fmt:formatNumber value="${sfrndMberStat.m1}" pattern="###,###,###"/></td>
										<td><fmt:formatNumber value="${sfrndMberStat.m2}"  pattern="###,###,###"/></td>
										<td><fmt:formatNumber value="${sfrndMberStat.m3}"  pattern="###,###,###"/></td>
										<td><fmt:formatNumber value="${sfrndMberStat.m4}"  pattern="###,###,###"/></td>
										<td><fmt:formatNumber value="${sfrndMberStat.m5}"  pattern="###,###,###"/></td>
										<td><fmt:formatNumber value="${sfrndMberStat.m6}"  pattern="###,###,###"/></td>
										<td><fmt:formatNumber value="${sfrndMberStat.m7}"  pattern="###,###,###"/></td>
										<td><fmt:formatNumber value="${sfrndMberStat.m8}"  pattern="###,###,###"/></td>
										<td><fmt:formatNumber value="${sfrndMberStat.m9}"  pattern="###,###,###"/></td>
										<td><fmt:formatNumber value="${sfrndMberStat.m10}" pattern="###,###,###"/></td>
										<td><fmt:formatNumber value="${sfrndMberStat.m11}" pattern="###,###,###"/></td>
										<td><fmt:formatNumber value="${sfrndMberStat.m12}" pattern="###,###,###"/></td>
										<td class="font-bold"><fmt:formatNumber value="${sfrndMberStat.total}" pattern="###,###,###"/></td>
									</tr>
									
									
									<c:set var="beforeYearF" value="${sfrndMberStat.year}"/>
								</c:forEach>
								
								<%-- 합계 ROW --%>
								<c:forEach var="sfrndMberStat" items="${sfrndMberStatus}" varStatus="status">
									<c:set var="m1SumF" value="${m1SumF+sfrndMberStat.m1}"/>
									<c:set var="m2SumF" value="${m2SumF+sfrndMberStat.m2}"/>
									<c:set var="m3SumF" value="${m3SumF+sfrndMberStat.m3}"/>
									<c:set var="m4SumF" value="${m4SumF+sfrndMberStat.m4}"/>
									<c:set var="m5SumF" value="${m5SumF+sfrndMberStat.m5}"/>
									<c:set var="m6SumF" value="${m6SumF+sfrndMberStat.m6}"/>
									<c:set var="m7SumF" value="${m7SumF+sfrndMberStat.m7}"/>
									<c:set var="m8SumF" value="${m8SumF+sfrndMberStat.m8}"/>
									<c:set var="m9SumF" value="${m9SumF+sfrndMberStat.m9}"/>
									<c:set var="m10SumF" value="${m10SumF+sfrndMberStat.m10}"/>
									<c:set var="m11SumF" value="${m11SumF+sfrndMberStat.m11}"/>
									<c:set var="m12SumF" value="${m12SumF+sfrndMberStat.m12}"/>
									<c:set var="totalSumF" value="${totalSumF+sfrndMberStat.total}"/>
								</c:forEach>
								<tr>
									<td class="font-bold t-center" colspan="3">합계</td> <!-- 연도 -->
									
									<td class="font-bold"><fmt:formatNumber value="${m1SumF}" pattern="###,###,###"/></td>
									<td class="font-bold"><fmt:formatNumber value="${m2SumF}"  pattern="###,###,###"/></td>
									<td class="font-bold"><fmt:formatNumber value="${m3SumF}"  pattern="###,###,###"/></td>
									<td class="font-bold"><fmt:formatNumber value="${m4SumF}"  pattern="###,###,###"/></td>
									<td class="font-bold"><fmt:formatNumber value="${m5SumF}"  pattern="###,###,###"/></td>
									<td class="font-bold"><fmt:formatNumber value="${m6SumF}"  pattern="###,###,###"/></td>
									<td class="font-bold"><fmt:formatNumber value="${m7SumF}"  pattern="###,###,###"/></td>
									<td class="font-bold"><fmt:formatNumber value="${m8SumF}"  pattern="###,###,###"/></td>
									<td class="font-bold"><fmt:formatNumber value="${m9SumF}"  pattern="###,###,###"/></td>
									<td class="font-bold"><fmt:formatNumber value="${m10SumF}" pattern="###,###,###"/></td>
									<td class="font-bold"><fmt:formatNumber value="${m11SumF}" pattern="###,###,###"/></td>
									<td class="font-bold"><fmt:formatNumber value="${m12SumF}" pattern="###,###,###"/></td>
									<td class="textR font-bold"><fmt:formatNumber value="${totalSumF}" pattern="###,###,###"/></td>
								</tr>
								<%-- 합계 ROW --%>	
									
								
							</tbody>
						</table>
					</div>
					<div class="table-bottom-control">
						<div class="form-inline">
							<div class="input-group col-md-10 col-xs-10 col-sm-10 t-left">
							<span>※ 시도/시군구 별 사용자가입 현황</span>
							<br/>
							<span>※ '시/군/구' 항목이 '시/도'항목의 명칭과 같은 경우, 해당 시·도청 자체 소속의 사용자가 사용자가입 한 횟수</span>
							</div>
							<div class="input-group col-md-2 col-xs-2 col-sm-2 t-right">
								<span>※ 단위(명)</span>
							</div>
						</div>
					</div>
					<div class="table-bottom-control marT20">
						<button type="button" class="btn dark" title="엑셀다운로드버튼" onclick="excelDownload('F');">엑셀</button>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- 컨텐츠 행 끝 -->
	
	<div class="contents-row">
		<div class="portlet">
			<div class="portlet-body">
				<div class="portlet-body-hr">
					<h3 class="portlet-body-title">월별 알림 발송 건수 현황</h3>
                	<hr class="portlet-body-title-hr">
                	
                	<form name="searchFormE" method="post">
                    <table class="search-panel table table-bordered">
                        <caption>월별 알림 발송 건수 현황 검색조건</caption>
                        
                        <colgroup>
                            <col style="width: 10%;">
                            <col style="width: auto;">						
                        </colgroup>
                        
                        <tbody>
                            <tr>
                                <th class="td-head" scope="row">
                                    <label class="input-label-none" for="searchDeCnd">검색연도</label>검색연도
                                </th>
                                
                                <td>
                                    <div class="form-inline">
                                        
                                        
                                        <!--input id명칭과 for가 동일해야함 (웹접근성)-->
                                        <label class="input-label-none" for="searchBgnDeI">label명</label>
                                        <div class="input-group input-icon date year-picker">
                                            <i class="fa fa-calendar"></i>
                                            <input type="text" id="searchBgnDeI" name="searchBgnDeI" title="년도" class="form-control" placeholder="년도를 선택하세요." value="<c:out value="${searchVO.searchBgnDeI}"/>">
                                        </div>
                                        <script>       
                                            $('#searchBgnDeI').datepicker({
                                                format: 'yyyy',
                                                viewMode: "years", 
                                                minViewMode: 'years',
                                                autoclose:true,
                                                endDate:'-0y'
                                            }).on('changeDate', function(e) {
                                                changeStartYear(e,"I");
                                            });
                                        </script>
                                        
                                        <span> ~ </span>
                                        
                                        <!--input id명칭과 for가 동일해야함 (웹접근성)-->
                                        <label class="input-label-none" for="searchEndDeI">label명</label>
                                        <div class="input-group input-icon date year-picker">
                                            <i class="fa fa-calendar"></i>
                                            <input type="text" id="searchEndDeI" name="searchEndDeI" title="년도" class="form-control" placeholder="년도를 선택하세요." value="<c:out value="${searchVO.searchEndDeI}"/>">
                                        </div>
                                        <script>       
                                            $('#searchEndDeI').datepicker({
                                                format: 'yyyy',
                                                viewMode: "years", 
                                                minViewMode: 'years',
                                                autoclose:true,
                                                endDate:'+0y'
                                            }).on('changeDate', function(e) {
                                                changeEndYear(e,"I");
                                            });
                                        </script>
                                        
                                        <span class="marL30"> 날짜제한 : </span>
                                        
                                        <!--input id명칭과 for가 동일해야함 (웹접근성)-->
                                        <label class="input-label-none" for="searchEndYmdI">label명</label>
                                        <div class="input-group input-icon date year-picker">
                                            <i class="fa fa-calendar"></i>
                                            <input type="text" id="searchEndYmdI" name="searchEndYmdI" value="<c:out value="${searchVO.searchEndYmdI}"/>" title="공지기한" class="form-control">
                                        </div>
                                        <script>       
                                            $('#searchEndYmdI').datepicker({
                                                format: 'yyyy-mm-dd',
                                                viewMode: "days", 
                                                minViewMode: 'days',
                                                autoclose:true,
                                                endDate:'+0d',
                                                immediateUpdates: true
                                            });											
                                        </script>
                                        <span> 까지 </span>
                                    </div>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </form>
                <div class="table-bottom-control">
                    <button type="button" class="btn btn-primary" onclick="selectSearchList('I');" title="월별알림발송건수 검색버튼">검색</button>
                    <button type="button" class="btn dark" onclick="resetCondition('I');" title="월별알림발송건수 검색조건초기화버튼">초기화</button>
                </div>
                
                <div class="table-scrollable marT20 marB0">
                    <table class="table table-bordered">
                        <caption>테이블 요약</caption>
                        <colgroup>
                            <col style="width:8%;">
                            <col style="width:auto;">
                            <col style="width:auto;">
                            <col style="width:auto;">
                            <col style="width:auto;">
                            <col style="width:auto;">
                            <col style="width:auto;">
                            <col style="width:auto;">
                            <col style="width:auto;">
                            <col style="width:auto;">
                            <col style="width:auto;">
                            <col style="width:auto;">
                            <col style="width:auto;">
                            <col style="width:auto;">
                            <col style="width:auto;">
                        </colgroup>
                        <thead>
                            <tr>
                                <th scope="col">연도</th>
                                <th scope="col">1월</th>
                                <th scope="col">2월</th>
                                <th scope="col">3월</th>
                                <th scope="col">4월</th>
                                <th scope="col">5월</th>
                                <th scope="col">6월</th>
                                <th scope="col">7월</th>
                                <th scope="col">8월</th>
                                <th scope="col">9월</th>
                                <th scope="col">10월</th>
                                <th scope="col">11월</th>
                                <th scope="col">12월</th>
                                <th scope="col">연간 알림건수</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="testNoteCount" items="${monthNoteSendStatus}" varStatus="status">
                                <tr>
                                    <td class="textR font-bold t-center"><c:out value="${testNoteCount.year}"/></td>
                                    <td><fmt:formatNumber value="${testNoteCount.m1}" pattern="###,###,###"/></td>
                                    <td><fmt:formatNumber value="${testNoteCount.m2}"  pattern="###,###,###"/></td>
                                    <td><fmt:formatNumber value="${testNoteCount.m3}"  pattern="###,###,###"/></td>
                                    <td><fmt:formatNumber value="${testNoteCount.m4}"  pattern="###,###,###"/></td>
                                    <td><fmt:formatNumber value="${testNoteCount.m5}"  pattern="###,###,###"/></td>
                                    <td><fmt:formatNumber value="${testNoteCount.m6}"  pattern="###,###,###"/></td>
                                    <td><fmt:formatNumber value="${testNoteCount.m7}"  pattern="###,###,###"/></td>
                                    <td><fmt:formatNumber value="${testNoteCount.m8}"  pattern="###,###,###"/></td>
                                    <td><fmt:formatNumber value="${testNoteCount.m9}"  pattern="###,###,###"/></td>
                                    <td><fmt:formatNumber value="${testNoteCount.m10}" pattern="###,###,###"/></td>
                                    <td><fmt:formatNumber value="${testNoteCount.m11}" pattern="###,###,###"/></td>
                                    <td><fmt:formatNumber value="${testNoteCount.m12}" pattern="###,###,###"/></td>
                                    <td class="font-bold"><fmt:formatNumber value="${testNoteCount.total}" pattern="###,###,###"/></td>
                                </tr>
                            </c:forEach>
                           	
                            
                        </tbody>
                    </table>
                </div>
				</div>
			</div>
		</div>
	</div>

</div>
<!-- 내용 끝 -->
```
