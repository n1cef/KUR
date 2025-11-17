# Angular CLI Package for Kraken OS

This package provides the Angular CLI (Command Line Interface) for developing Angular applications on Kraken OS, with built-in support for Atomic Design methodology.

## Quick Start

### Installation

```bash
kraken install angular
```

This will automatically install Node.js as a dependency if not already installed.

### Verify Installation

```bash
ng version
```

### Create Your First Angular App

```bash
ng new my-app --routing --style=scss
cd my-app
ng serve
```

Then open http://localhost:4200 in your browser.

## Atomic Design Support

This package includes comprehensive documentation for implementing Atomic Design patterns in your Angular applications.

See [ATOMIC_DESIGN_GUIDE.md](./ATOMIC_DESIGN_GUIDE.md) for:
- Complete explanation of Atomic Design methodology
- Step-by-step setup guide
- Code examples for all component levels
- Project structure recommendations
- Best practices

### Quick Atomic Design Setup

After creating your app, set up the Atomic Design structure:

```bash
ng generate module shared/components/atoms
ng generate module shared/components/molecules
ng generate module shared/components/organisms
ng generate module shared/components/templates
ng generate module shared/components/pages
```

## What is Atomic Design?

Atomic Design breaks down UI components into five levels:

1. **Atoms** - Basic elements (buttons, inputs)
2. **Molecules** - Simple component groups (search box)
3. **Organisms** - Complex components (header, navigation)
4. **Templates** - Page layouts
5. **Pages** - Specific page instances

## Common Commands

```bash
# Create a new component
ng generate component path/component-name

# Create a new service
ng generate service path/service-name

# Build for production
ng build --prod

# Run tests
ng test

# Get help
ng help
```

## Dependencies

- Node.js v22.13.1+ (automatically installed)
- npm (included with Node.js)

## Version

Angular CLI v19.0.6

## Resources

- [Full Atomic Design Guide](./ATOMIC_DESIGN_GUIDE.md)
- [Angular Documentation](https://angular.io/docs)
- [Atomic Design Book](https://atomicdesign.bradfrost.com/)

## Support

For package-specific issues, please refer to the KUR repository.
For Angular-specific questions, see the [Angular Documentation](https://angular.io/docs).
