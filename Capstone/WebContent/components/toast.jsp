<div id="toast" class="toast" role="alert" aria-live="assertive" aria-atomic="true" data-delay="4000" style="position: absolute; bottom: 50px; right: 50px;">
  <div class="toast-header">
    <!-- <img src="..." class="rounded mr-2" alt="...">  -->
    <strong class="mr-auto">[[TOASTTITLE]]</strong>
    <!-- <small>11 mins ago</small>  -->
    <button type="button" class="ml-2 mb-1 close" data-dismiss="toast" aria-label="Close">
      <span aria-hidden="true">&times;</span>
    </button>
  </div>
  <div class="toast-body">
  	<a style="color: black;">
    	[[TOASTMESSAGE]]
    </a>
  </div>
</div>
<script>
	$("#toast").toast('show');
</script>