<style>
#event-header {
	height: auto;
	width: 100%;
	text-align: center;
}
#event-info button {
	background-color: red;
}
</style>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%@ page import="utils.FolderReader" %>

<!DOCTYPE html>
<html>
<head>
<link
	href="https://fonts.googleapis.com/css?family=Roboto:100,300,400,500,700,900|Material+Icons"
	rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/vuetify/dist/vuetify.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
	integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T"
	crossorigin="anonymous">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
	integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
	crossorigin="anonymous"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"
	integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1"
	crossorigin="anonymous"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"
	integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM"
	crossorigin="anonymous"></script>

<link rel="stylesheet" href="styles.css">
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no, minimal-ui">

<title>Event Page</title>
</head>
<body>

<% 
	FolderReader fr = new FolderReader("/images/eventImages");
%>

	<%@include file="Nav.jsp"%>
	<div id="event-header">
			<div id="carouselExampleIndicators" class="carousel slide" data-ride="carousel">
				<ol class="carousel-indicators">
					<li data-target="#carouselExampleIndicators" data-slide-to="0" class="active"></li>
					<% 
					for(int i = 1; i < fr.getFileList().length; i++) { 
					%>
						<li data-target="#carouselExampleIndicators" data-slide-to=<%= i %>></li>
					<%
					} 
					%>
				</ol>
				<div class="carousel-inner">
					<% 
					String[] carouselItems = fr.getFileList();
					%>
					<div class="carousel-item active">
					<img class="d-block w-100 img-fluid" src="./images/eventImages/<%= carouselItems[0] %>" alt="Slide 1">
					</div>
					<%
					for(int i = 1; i < carouselItems.length; i++) { 
					%>
					<div class="carousel-item">
						<img class="d-block w-100 img-fluid" src="./images/eventImages/<%= carouselItems[i] %>" alt="Slide <%= i + 1 %>">
					</div>
					<%
					} 
					%>	
				</div>
				<a class="carousel-control-prev" href="#carouselExampleIndicators"
					role="button" data-slide="prev"> <span
					class="carousel-control-prev-icon" aria-hidden="true"></span> <span
					class="sr-only">Previous</span>
				</a> <a class="carousel-control-next" href="#carouselExampleIndicators"
					role="button" data-slide="next"> <span
					class="carousel-control-next-icon" aria-hidden="true"></span> <span
					class="sr-only">Next</span>
				</a>
			</div>
		<div id="event-info">
			<h1 id="event-name"><b>Event Name Goes here</b></h1><br>
			<h2 id="event-subheadinfo">The following is filler text for visual appeal</h2><br>
			<p class="event-text">Buck did not read the newspapers, or he would have known that
trouble was brewing, not alone for himself, but for every tide-
water dog, strong of muscle and with warm, long hair, from Puget
Sound to San Diego. Because men, groping in the Arctic darkness,
had found a yellow metal, and because steamship and transportation
companies were booming the find, thousands of men were rushing
into the Northland. These men wanted dogs, and the dogs they
wanted were heavy dogs, with strong muscles by which to toil, and
furry coats to protect them from the frost.
<br><br>
Buck lived at a big house in the sun-kissed Santa Clara Valley.
Judge Miller's place, it was called. It stood back from the road,
half hidden among the trees, through which glimpses could be
caught of the wide cool veranda that ran around its four sides.
The house was approached by gravelled driveways which wound about
through wide-spreading lawns and under the interlacing boughs of
tall poplars. At the rear things were on even a more spacious
scale than at the front. There were great stables, where a dozen
grooms and boys held forth, rows of vine-clad servants' cottages,
an endless and orderly array of outhouses, long grape arbors,
green pastures, orchards, and berry patches. Then there was the
pumping plant for the artesian well, and the big cement tank where
Judge Miller's boys took their morning plunge and kept cool in the
hot afternoon.
<br><br>
And over this great demesne Buck ruled. Here he was born, and
here he had lived the four years of his life. It was true, there
were other dogs, There could not but be other dogs on so vast a
place, but they did not count. They came and went, resided in the
populous kennels, or lived obscurely in the recesses of the house
after the fashion of Toots, the Japanese pug, or Ysabel, the
Mexican hairless,--strange creatures that rarely put nose out of
doors or set foot to ground. On the other hand, there were the fox
terriers, a score of them at least, who yelped fearful promises at
Toots and Ysabel looking out of the windows at them and protected
by a legion of housemaids armed with brooms and mops.
<br><br>
But Buck was neither house-dog nor kennel-dog. The whole realm
was his. He plunged into the swimming tank or went hunting with
the Judge's sons; he escorted Mollie and Alice, the Judge's
daughters, on long twilight or early morning rambles; on wintry
nights he lay at the Judge's feet before the roaring library fire;
he carried the Judge's grandsons on his back, or rolled them in
the grass, and guarded their footsteps through wild adventures
down to the fountain in the stable yard, and even beyond, where
the paddocks were, and the berry patches. Among the terriers he
stalked imperiously, and Toots and Ysabel he utterly ignored, for
he was king,--king over all creeping, crawling, flying things of
Judge Miller's place, humans included.
<br><br>
His father, Elmo, a huge St. Bernard, had been the Judge's
inseparable companion, and Buck bid fair to follow in the way of
his father. He was not so large,--he weighed only one hundred and
forty pounds,--for his mother, Shep, had been a Scotch shepherd
dog. Nevertheless, one hundred and forty pounds, to which was
added the dignity that comes of good living and universal respect,
enabled him to carry himself in right royal fashion. During the
four years since his puppyhood he had lived the life of a sated
aristocrat; he had a fine pride in himself, was even a trifle
egotistical, as country gentlemen sometimes become because of
their insular situation. But he had saved himself by not becoming
a mere pampered house-dog. Hunting and kindred outdoor delights
had kept down the fat and hardened his muscles; and to him, as to
the cold-tubbing races, the love of water had been a tonic and a
health preserver.
<br><br>
And this was the manner of dog Buck was in the fall of 1897, when
the Klondike strike dragged men from all the world into the frozen
North. But Buck did not read the newspapers, and he did not know
that Manuel, one of the gardener's helpers, was an undesirable
acquaintance. Manuel had one besetting sin. He loved to play
Chinese lottery. Also, in his gambling, he had one besetting
weakness--faith in a system; and this made his damnation certain.
For to play a system requires money, while the wages of a
gardener's helper do not lap over the needs of a wife and numerous
progeny.</p><br><br>
			<button type="button" id="rsvp-button">RSVP</button>
			<button type="button" id="event-theme-button">Event Theme</button>
			<button type="button" id="event-schedule-button">Event Schedule</button>
			<button type="button" id="discord-button">Developer Discord</button>
		</div>
	</div>
</body>
</html>