# ITDC Fourstead

*   [Introduction](#introduction)
*   [Installation & Setup](#installation-and-setup)
    *   [First Steps](#first-steps)
    *   [Configuring Fourstead](#configuring-fourstead)
    *   [Launching The Vagrant Box](#launching-the-vagrant-box)
    *   [Per Project Installation](#per-project-installation)
*   [Daily Usage](#daily-usage)
    *   [Accessing Fourstead Globally](#accessing-fourstead-globally)
    *   [Connecting Via SSH](#connecting-via-ssh)
    *   [Connecting To Databases](#connecting-to-databases)
    *   [Adding Additional Sites](#adding-additional-sites)
    *   [Configuring Cron Schedules](#configuring-cron-schedules)
    *   [Ports](#ports)

## [Introduction](#introduction)

ITDCMS strives to make the entire PHP development experience delightful, including your local development environment. [Vagrant](http://vagrantup.com) provides a simple, elegant way to manage and provision Virtual Machines.

ITDCMS Fourstead is an official, pre-packaged Vagrant box that provides you a wonderful development environment without requiring you to install PHP, HHVM, a web server, and any other server software on your local machine. No more worrying about messing up your operating system! Vagrant boxes are completely disposable. If something goes wrong, you can destroy and re-create the box in minutes!

Fourstead runs on any Windows, Mac, or Linux system, and includes the Nginx web server, PHP 5.6, MySQL, Postgres, Redis, Memcached, Node, and all of the other goodies you need to develop amazing web applications.

> **Note:** If you are using Windows, you may need to enable hardware virtualization (VT-x). It can usually be enabled via your BIOS.

### Included Software

*   Ubuntu Server 14.04 LTS
*   Git
*   PHP 5.6
*   Nginx
*   MySQL
*   Sqlite3
*   Postgres
*   Composer
*   Node (With PM2, Bower, Grunt, and Gulp)
*   Redis
*   Memcached

## [Installation & Setup](#installation-and-setup)

### First Steps

Before launching your Fourstead environment, you must install [VirtualBox 5.x](https://www.virtualbox.org/wiki/Downloads) or [VMWare](http://www.vmware.com) as well as [Vagrant](http://www.vagrantup.com/downloads.html). All of these software packages provide easy-to-use visual installers for all popular operating systems.

To use the VMware provider, you will need to purchase both VMware Fusion / Workstation and the [VMware Vagrant plug-in](http://www.vagrantup.com/vmware). Though it is not free, VMware can provide faster shared folder performance out of the box.

#### Installing The Fourstead Vagrant Box

Once VirtualBox / VMware and Vagrant have been installed, you should add the `itdc/fourstead` box to your Vagrant installation using the following command in your terminal. It will take a few minutes to download the box, depending on your Internet connection speed:

    vagrant box add itdc/fourstead

If this command fails, make sure your Vagrant installation is up to date.

#### Installing Fourstead

You may install Fourstead by simply cloning the repository. Consider cloning the repository into a `Fourstead` folder within your "home" directory, as the Fourstead box will serve as the host to all of your ITDCMS projects:

    cd ~

    git clone https://github.com/itdc/fourstead.git Fourstead

Once you have cloned the Fourstead repository, run the `bash init.sh` command from the Fourstead directory to create the `Fourstead.yaml` configuration file. The `Fourstead.yaml` file will be placed in the `~/.fourstead` hidden directory:

    bash init.sh

### Configuring Fourstead

#### Setting Your Provider

The `provider` key in your `~/.fourstead/Fourstead.yaml` file indicates which Vagrant provider should be used: `virtualbox`, `vmware_fusion`, or `vmware_workstation`. You may set this to the provider you prefer:

    provider: virtualbox

#### Configuring Shared Folders

The `folders` property of the `Fourstead.yaml` file lists all of the folders you wish to share with your Fourstead environment. As files within these folders are changed, they will be kept in sync between your local machine and the Fourstead environment. You may configure as many shared folders as necessary:

    folders:
        - map: ~/Code
          to: /home/vagrant/Code

To enable [NFS](http://docs.vagrantup.com/v2/synced-folders/nfs.html), just add a simple flag to your synced folder configuration:

    folders:
        - map: ~/Code
          to: /home/vagrant/Code
          type: "nfs"

#### Configuring Nginx Sites

Not familiar with Nginx? No problem. The `sites` property allows you to easily map a "domain" to a folder on your Fourstead environment. A sample site configuration is included in the `Fourstead.yaml` file. Again, you may add as many sites to your Fourstead environment as necessary. Fourstead can serve as a convenient, virtualized environment for every ITDCMS project you are working on:

    sites:
        - map: fourstead.dev
          to: /home/vagrant/Code/ITDCMS/public

You can make any Fourstead site use [HHVM](http://hhvm.com) by setting the `hhvm` option to `true`:

    sites:
        - map: fourstead.dev
          to: /home/vagrant/Code/ITDCMS/public
          hhvm: true

#### The Hosts File

You must add the "domains" for your Nginx sites to the `hosts` file on your machine. The `hosts` file will redirect requests for your Fourstead sites into your Fourstead machine. On Mac and Linux, this file is located at `/etc/hosts`. On Windows, it is located at `C:\Windows\System32\drivers\etc\hosts`. The lines you add to this file will look like the following:

    192.168.10.10  fourstead.dev

Make sure the IP address listed is the one set in your `~/.fourstead/Fourstead.yaml` file. Once you have added the domain to your `hosts` file, you can access the site via your web browser:

    http://fourstead.dev

### Launching The Vagrant Box

Once you have edited the `Fourstead.yaml` to your liking, run the `vagrant up` command from your Fourstead directory. Vagrant will boot the virtual machine and automatically configure your shared folders and Nginx sites.

To destroy the machine, you may use the `vagrant destroy --force` command.

### Per Project Installation

Instead of installing Fourstead globally and sharing the same Fourstead box across all of your projects, you may instead configure a Fourstead instance for each project you manage. Installing Fourstead per project may be beneficial if you wish to ship a `Vagrantfile` with your project, allowing others working on the project to simply `vagrant up`.

To install Fourstead directly into your project, require it using Composer:

    composer require itdc/fourstead --dev

Once Fourstead has been installed, use the `make` command to generate the `Vagrantfile` and `Fourstead.yaml` file in your project root. The `make` command will automatically configure the `sites` and `folders` directives in the `Fourstead.yaml` file.

Mac / Linux:

    php vendor/bin/fourstead make

Windows:

    vendor\bin\fourstead make

Next, run the `vagrant up` command in your terminal and access your project at `http://fourstead.dev` in your browser. Remember, you will still need to add an `/etc/hosts` file entry for `fourstead.dev` or the domain of your choice.

## [Daily Usage](#daily-usage)

### Accessing Fourstead Globally

Sometimes you may want to `vagrant up` your Fourstead machine from anywhere on your filesystem. You can do this by adding a simple Bash alias to your Bash profile. This alias will allow you to run any Vagrant command from anywhere on your system and will automatically point that command to your Fourstead installation:

    alias fourstead='function __fourstead() { (cd ~/Fourstead && vagrant $*); unset -f __fourstead; }; __fourstead'

Make sure to tweak the `~/Fourstead` path in the alias to the location of your actual Fourstead installation. Once the alias is installed, you may run commands like `fourstead up` or `fourstead ssh` from anywhere on your system.

### Connecting Via SSH

You can SSH into your virtual machine by issuing the `vagrant ssh` terminal command from your Fourstead directory.

But, since you will probably need to SSH into your Fourstead machine frequently, consider adding the "alias" described above to your host machine to quickly SSH into the Fourstead box.

### Connecting To Databases

A `fourstead` database is configured for both MySQL and Postgres out of the box. For even more convenience, ITDCMS's `.env` file configures the framework to use this database out of the box.

To connect to your MySQL or Postgres database from your host machine via Navicat or Sequel Pro, you should connect to `127.0.0.1` and port `33060` (MySQL) or `54320` (Postgres). The username and password for both databases is `fourstead` / `secret`.

> **Note:** You should only use these non-standard ports when connecting to the databases from your host machine. You will use the default 3306 and 5432 ports in your ITDCMS database configuration file since ITDCMS is running _within_ the virtual machine.

### Adding Additional Sites

Once your Fourstead environment is provisioned and running, you may want to add additional Nginx sites for your ITDCMS applications. You can run as many ITDCMS installations as you wish on a single Fourstead environment. To add an additional site, simply add the site to your `~/.fourstead/Fourstead.yaml` file and then run the `vagrant provision` terminal command from your Fourstead directory.

### Configuring Cron Schedules

ITDCMS provides a convenient way to schedule Cron jobs by scheduling a single `schedule:run` Artisan command to be run every minute. The `schedule:run` command will examine the job scheduled defined in your `ITDCMS\System\App\Console\Kernel` class to determine which jobs should be run.

If you would like the `schedule:run` command to be run for a Fourstead site, you may set the `schedule` option to `true` when defining the site:

    sites:
        - map: fourstead.dev
          to: /home/vagrant/Code/ITDCMS/public
          schedule: true

The Cron job for the site will be defined in the `/etc/cron.d` folder of the virtual machine.

### Ports

By default, the following ports are forwarded to your Fourstead environment:

*   **SSH:** 2222 → Forwards To 22
*   **HTTP:** 8000 → Forwards To 80
*   **HTTPS:** 44300 → Forwards To 443
*   **MySQL:** 33060 → Forwards To 3306
*   **Postgres:** 54320 → Forwards To 5432

#### Forwarding Additional Ports

If you wish, you may forward additional ports to the Vagrant box, as well as specify their protocol:

    ports:
        - send: 93000
          to: 9300
        - send: 7777
          to: 777
          protocol: udp

