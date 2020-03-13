# Who's staying home because of COVID-19?

This is a running list of companies that are taking steps to address
the spread of COVID-19. Pull requests gratefully accepted, especially
around design or data formatting or correctness. If you are a
journalist and would like to speak to someone about the list, email
phildini@phildini.net.  View the live website here:
[stayinghome.club](https://stayinghome.club).


## How do I add my company?

The short version is: the website is generated from the
[`companies.yml`](_data/companies.yml) file.  Add the details of your
company by mimicking what others have done, and create a PR.  If
you're not familiar with Git or Pull Requests, here are the steps.
You will need a Github account.

1. Make sure you're editing the main repository which hosts the
    website.  It is here on Github:
    [`https://github.com/phildini/stayinghomeclub`](https://github.com/phildini/stayinghomeclub).

1. Find the `companies.yml` file, and click the "Edit" button.  Here's
   a [direct link to the Edit
   page](https://github.com/phildini/stayinghomeclub/edit/master/_data/companies.yml).  Please try
   to put your new entry in roughly alphabetical order, by name, relative to existing companies.

1. Add your company, or update its details if something has changed.

1. Click "Propose File Change", the big green button at the bottom of
   the page.

1. This will take you to a page where you can click "Create pull
   request".  Once you do that, one of the maintainers of the website
   will attend to your update ASAP.

1. Thank you for helping us keep this site up-to-date! 🙏


## For developers

You may want to run the site locally, to see what it looks like while
you're making changes.  A full tutorial is out of scope here, but
these are the basic steps.  We assume you know a little bit of Ruby.

First, you'll need Ruby Bundler, which manages this project's
dependencies.

```
gem install bundler -v 2.1.4
```

Now, install the required Gems.

```
bundle install
```

When that's done, run the development server.

```
bundle exec jekyll serve
```

Jekyll will print a URL where you can see your local version running,
as it would on the web.  Usually that's
[`http://127.0.0.1:4000/`](http://127.0.0.1:4000/).
