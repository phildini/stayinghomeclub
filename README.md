# Who's staying home because of COVID-19?

This is the running list of what in tech has been affected by COVID-19. Pull requests gratefully accepted, especially around design or data formatting or correctness. If you are a journalist and would like to speak to someone about the list, email phildini@phildini.net.


Skip to: <a href="#companies">Companies</a>. Skip to: <a href="#events">Events</a>

<a name="companies"></a>
## Companies - {{ site.data.companies | size }}
{% assign sorted = (site.data.companies | sort: 'name') %}
| Company | WFH | Travel | Visitors | Events | Last Update |
| --- | --- | --- | --- | --- | --- |
{% for company in sorted %}| {{company.name}} | {{company.wfh}} | {{company.travel}} | {{company.visitors}} | {{company.events}} | {{company.last_update}} |
{% endfor %}

Back to top: <a href="#companies">Companies</a>

<a name="events"></a>
## Events - {{ site.data.events | size }}
{% for event in site.data.events %}
- {{event.name}}: {{event.status}}{% endfor %}
