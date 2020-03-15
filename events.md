# What events are staying home because of COVID-19?

---

Go [Home](/). Jump to: <a href="/companies.html">Companies</a>. Jump to: <a href="/universities.html">Universities</a>.

---

<a name="events"></a>
{% assign cancelled = site.data.events | where_exp:"item", "item.status contains 'cancelled'" | size %}

## Events - {{ site.data.events | size }}

*Events cancelled: **{{cancelled}}***

{% for event in site.data.events %}
- {{event.name}}: {{event.status}}{% endfor %}

---

Back to top: <a href="#events">Events</a>. Jump to: <a href="/companies.html">Companies</a>. Jump to: <a href="/universities.html">Universities</a>. Go [Home](/)
