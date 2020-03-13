# Who's staying home because of COVID-19?

This is the running list of what in tech has been affected by COVID-19. Pull requests gratefully accepted, especially around design or data formatting or correctness. If you are a journalist and would like to speak to someone about the list, email phildini@phildini.net.

Skip to: <a href="#companies">Companies</a>. Skip to: <a href="#events">Events</a>. Skip to: <a href="#universities">Universities</a>.

<a name="companies"></a>
## Companies - {{ site.data.companies | size }}
{% assign sorted = (site.data.companies | sort: 'name') %}
{% assign wfh_required = (site.data.companies | where_exp:"item", "item.wfh contains 'Required'" | size ) %}
{% assign wfh_encouraged = (site.data.companies | where_exp:"item", "item.wfh contains 'Encouraged'" | size ) %}

*Work from home required: **{{ wfh_required}}**, Work from home encouraged: **{{ wfh_encouraged }}***

| Company | WFH | Travel | Visitors | Events | Last Update |
| --- | --- | --- | --- | --- | --- |
{% for company in sorted %}| {{company.name}} | {{company.wfh}} | {{company.travel}} | {{company.visitors}} | {{company.events}} | {{company.last_update}} |
{% endfor %}

Back to top: <a href="#companies">Companies</a>

<a name="events"></a>
{% assign cancelled = (site.data.events | where_exp:"item", "item.status contains 'cancelled'"  | size)%}

## Events - {{ site.data.events | size }}

*Events cancelled: **{{cancelled}}***

{% for event in site.data.events %}
- {{event.name}}: {{event.status}}{% endfor %}

Back to top: <a href="#companies">Companies</a>, <a href="#events">Events</a>

<a name="universities"></a>

## Universities -- {{ site.data.universities | size }}

{% assign statuses = "" | split: "" %}
{% for university in site.data.universities %}
    {% assign status = university[1].status | downcase %}
    {% assign statuses = statuses | push: status %}
{% endfor %}
{% assign remote_count = (statuses | where_exp:"status", "status contains 'remote'" | size)%}
*Universities moving to remote teaching: **{{remote_count}}***

{% for university_hash in site.data.universities -%}
{% assign university = university_hash[1] %}
- {{university.name}}: {{university.status}} (Last update: {{university.last_update}})
{%- endfor %}

Back to top: <a href="#companies">Companies</a>, <a href="#events">Events</a>, <a href="#universities">Universities</a>
