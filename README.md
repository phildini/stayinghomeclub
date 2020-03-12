# Who's staying home because of COVID-19?

This is the running list of what in tech has been affected by COVID-19. Pull requests gratefully accepted, especially around design or data formatting or correctness. You can provide your company's updates in [this](https://forms.gle/ZqvxumZK5sAFdqNN8) google form.

<a name="companies"></a>
## Companies - {{ site.data.companies | size }}
{% assign sorted = (site.data.companies | sort: 'name') %}
| Company | WFH | Travel | Visitors | Events | Last Update |
| --- | --- | --- | --- | --- | --- |
{% for company in sorted %}| {{company.name}} | {{company.wfh}} | {{company.travel}} | {{company.visitors}} | {{company.events}} | {{company.last_update}} |
{% endfor %}

<a name="events"></a>
## Events - {{ site.data.events | size }}
{% for event in site.data.events %}
- {{event.name}}: {{event.status}}{% endfor %}
