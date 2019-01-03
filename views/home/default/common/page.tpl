{{if gt .Paginator.PageNums 1}}
<div class="pagination fr">
	<div class="lbf-pagination">
		<ul class="lbf-pagination-item-list">
			{{if .Paginator.HasPrev}}
				<li class="lbf-pagination-item"><a class="lbf-pagination-page" href="{{.Paginator.PageLinkFirst}}">{{i18n .Lang "paginator.first_page"}}</a></li>
				<li class="lbf-pagination-item"><a class="lbf-pagination-page" href="{{.Paginator.PageLinkPrev}}">&lt;</a></li>
			{{else}}
				<li class="lbf-pagination-item"><a class="lbf-pagination-page lbf-pagination-disabled">{{i18n .Lang "paginator.first_page"}}</a></li>
				<li class="lbf-pagination-item"><a class="lbf-pagination-page lbf-pagination-disabled">&lt;</a></li>
			{{end}}
			{{range $index, $page := .Paginator.Pages}}
				<li class="lbf-pagination-item">
					<a  class="lbf-pagination-page {{if $.Paginator.IsActive .}} lbf-pagination-current{{end}}" href="{{$.Paginator.PageLink $page}}">{{$page}}</a>
				</li>
			{{end}}
			{{if .Paginator.HasNext}}
				<li class="lbf-pagination-item"><a class="lbf-pagination-page" href="{{.Paginator.PageLinkNext}}">&gt;</a></li>
				<li class="lbf-pagination-item"><a class="lbf-pagination-page" href="{{.Paginator.PageLinkLast}}">{{i18n .Lang "paginator.last_page"}}</a></li>
			{{else}}
				<li class="lbf-pagination-item"><a class="lbf-pagination-page lbf-pagination-disabled">&gt;</a></li>
				<li class="lbf-pagination-item"><a class="lbf-pagination-page lbf-pagination-disabled">{{i18n .Lang "paginator.last_page"}}</a></li>
			{{end}}
		</ul>
	</div>
</div>
{{end}}
