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

1. You will need to create a YML file [in the `companies`
   directory](https://github.com/phildini/stayinghomeclub/tree/master/_data/companies).
   Navigate there, and click the "Create new file" button.  Here's a
   [direct link to the Create
   page](https://github.com/phildini/stayinghomeclub/new/master/_data/companies).

   Or, if you're just updating an existing entry, click on it, then
   hit the "Edit" button.

1. Give the file a name, something like `google.yml` or `envato.yml`
   or `ing.yml`, no fancy characters, and be sure to end it with
   **.yml**. Add the details about your company in this format:

      ```yaml
      name: Your company name
      wfh: Strongly Encouraged
      travel: Restricted
      visitors: Restricted
      events: Restricted
      last_update: 2020-03-13
      ```

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

```shell
gem install bundler -v 2.1.4
```

Now, install the required Gems.

```shell
bundle install
```

When that's done, run the development server.

```shell
bundle exec jekyll serve
```

Jekyll will print a URL where you can see your local version running,
as it would on the web.  Usually that's
[`http://127.0.0.1:4000/`](http://127.0.0.1:4000/).
