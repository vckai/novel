
    <div class="column-wrap">
        <h2 class="column-title">大家都在看</h2>
        <div class="horizontal-list3">
            <table>
                <tbody>
                    <tr id="recommend">
						{{range .NovRecs}}
						<td>
						<a href="{{urlfor "m.BookController.Index" ":id" .Id}}">
							<div class="book-detail">
								<div class="book-cover"><img src="{{$.mOut.ViewUrl}}img/nocover.jpg" data-echo="{{.Cover}}" alt="{{.Name}}"></div>
								<h3 class="book-title">{{.Name}}</h3>
							</div>
						</a>
						</td>
						{{end}}
                    </tr>
                </tbody>
            </table>
        </div>
        <div class="search-tag-change"><a href="javascript:void(0)" id="change"><i class="icon-change"></i>换一换</a></div>
    </div>
