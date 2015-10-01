/**
 * @author StevenSongHC (https://github.com/StevenSongHC)
 * @version 0.1.1
 */
;!function ( $, window ) {
	
	"use strict";
	
	var Pagination = function (element, options) {
		this.$element = $(element);
		var defaults = {
			itemClass: "item",
			pageSize: 5,
			currentPage: 1,
			style: 1
		};
		this.options = $.extend({}, defaults, options||{});
	};
	
	Pagination.prototype = {
		render: function() {
			var items = this.$element.children("*[class='" + this.options.itemClass + "']");
			// count params
			var totalCount = items.length;
			var pageCount = Math.ceil(totalCount / this.options.pageSize);
			this.options.currentPage = this.options.currentPage <= 0? 1 : (this.options.currentPage <= pageCount? this.options.currentPage : pageCount);
			
			// set the boundary of displaying items
			var start = (this.options.currentPage - 1) * this.options.pageSize;
			var end = this.options.currentPage * this.options.pageSize - 1;
			
			// display item page
			items.hide();
			items.each(function(i, e) {
				if (i >= start && i <= end) {
					$(e).show();
				}
			});
			
			// set page flag
			var isFirstPage = this.options.currentPage <= 1? true : false;
			var isLastPage = this.options.currentPage >= pageCount? true : false;
			if (pageCount == 1) {
				isFirstPage = true;
				isLastPage = true;
			}
			
			// draw pagination navigation bar
			this.$element.children("nav").remove();		// clear first
			var nb = "<nav>";
			switch (this.options.style) {
				case 1:
					nb += "<ul class='pager'>";
					if (!isFirstPage)
						nb += "<li data-page='" + (parseInt(this.options.currentPage) - 1) + "'><a href='javascript:void(0)'>&lt;</a></li>";
					if (!isLastPage)
						nb += "<li data-page='" + (parseInt(this.options.currentPage) + 1) + "'><a href='javascript:void(0)'>&gt;</a></li>";
					nb += "</ul>";
					break;
				case 2:
					nb += "<ul class='pager'>";
					if (!isFirstPage)
						nb += "<li class='previous' data-page='" + (parseInt(this.options.currentPage) - 1) + "'><a href='javascript:void(0)'>&lt;</a></li>";
					if (!isLastPage)
						nb += "<li class='next' data-page='" + (parseInt(this.options.currentPage) + 1) + "'><a href='javascript:void(0)'>&gt;</a></li>";
					nb += "</ul>";
					break;
				case 3:
					nb += "<center><ul class='pagination'>";
					nb += "<li data-page='" + (parseInt(this.options.currentPage) - 1) + "'";
					if (isFirstPage)
						nb += " style='visibility: hidden;'";
					nb += "><a href='javascript:void(0)'>&lt;</a></li>";
					nb += "<li data-page='" + (parseInt(this.options.currentPage) + 1) + "'";
					if (isLastPage)
						nb += " style='visibility: hidden;'";
					nb += "><a href='javascript:void(0)'>&gt;</a></li>";
					nb += "</ul></center>";
					break;
				default:
					nb += "<ul class='pager'>";
					if (!isFirstPage)
						nb += "<li data-page='" + (parseInt(this.options.currentPage) - 1) + "'><a href='javascript:void(0)'>&lt;</a></li>";
					if (!isLastPage)
						nb += "<li data-page='" + (parseInt(this.options.currentPage) + 1) + "'><a href='javascript:void(0)'>&gt;</a></li>";
					nb += "</ul>";
			}
			nb += "</nav>";
			
			this.$element.append(nb);
			
			var obj = this;
			this.$element.on("click", "nav a", (function (e) {
				obj.options.currentPage = $(this).parent().attr("data-page");
				obj.render();
			}));
		}
	};
	
	// re-define Pagination's constructor
	Pagination.prototype.constructor = Pagination;
	
	$.fn.pagination = function (options) {
		 // maintaining chainability, and can be used by different elements with the same attribution
		return this.each(function () {
			 new Pagination($(this), options).render();
		});
	};
	
}( jQuery, window );