# What companies are staying home because of COVID-19?

---

Go [Home](/). Jump to: <a href="/events.html">Events</a>. Jump to: <a href="/universities.html">Universities</a>.

---

<a name="companies"></a>
## Companies - {{ site.data.companies | size }}
{% assign sorted = site.data.companies | sort %}
{% assign wfh_required = site.data.companies | where_exp:"item", "item.wfh contains 'Required'" | size %}
{% assign wfh_encouraged = site.data.companies | where_exp:"item", "item.wfh contains 'Encouraged'" | size %}

*Work from home required: **{{ wfh_required}}**, Work from home encouraged: **{{ wfh_encouraged }}***

| Company | WFH | Travel | Visitors | Events | Last Update |
| --- | --- | --- | --- | --- | --- |
{% for company in sorted %}| {{company[1].name}} | {{company[1].wfh}} | {{company[1].travel}} | {{company[1].visitors}} | {{company[1].events}} | {{company[1].last_update}} |
{% endfor %}

---

Back to top: <a href="#companies">Companies</a>. Jump to: <a href="/events.html">Events</a>. Jump to: <a href="/universities.html">Universities</a>. Go [Home](/).
