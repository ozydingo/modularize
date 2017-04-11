# Modularizer
## Make modules, modularly

### What Modularizer does

Modularizer lets you easily and dynamically create and modify named modules and classes under a given namespace for greater flexibility during inheritance. Modularizer is most useful for writing generic reusable code such as gems.

A common use case for Modularizer is to create a module as a home for dynamically-named methods that (1) can be overridden by the model using these methods while still enabling access to `super`, and (2) are logically grouped in an isolated Module.

Another is as a find_or_create type feature for creating dynmically named (class and/or namespace) classes such as a utility class for each of several classes in a class ancestry tree.

To illustrate the first use case, let's say you're building some code that can add a method to a desired model. But this method -- either the name itself or its behavior -- actually depends on the model that is including it. A common example that many Rails developers use without knowing is `ActiveRecord::Base::GeneratedAssociationMethods`. This module is where the association methods are defined; e.g. if `Post belongs_to :author`, then the method `author` is defined on `Post::GeneratedAssociationMethods`. Note that this module needs to be specific to `Post`, and also needs method names that are dynamically determined by associations defined inside the `Post` model and thus cannot be written by ActiveRecord in a static module.The distinct advantage to this approach, as opposed to defining these methods directly on `Post`, is that `Post` is able to override `author` while still having access to `super`. Thus being able to do something special while retaining the original functionality. Plus, it's just good code organization to have all these methods defined in one, isolated module.

Instead of being ActiveRecord and creating this module for all descendents of some behemoth master base class, you want this feature for only the few seleccted models that include your gem.

Enter Modularizer. Modularizer allows you to easily follow this pattern and create a `Post::Foo` module or class on the fly, or use the existing one.

