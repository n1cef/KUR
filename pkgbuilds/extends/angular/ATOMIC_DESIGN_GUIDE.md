# Atomic Design with Angular on Kraken OS

This guide explains how to use the Angular CLI package on Kraken OS and how to implement Atomic Design methodology in your Angular applications.

## What is Atomic Design?

Atomic Design is a methodology for creating design systems, popularized by Brad Frost. It breaks down user interfaces into fundamental building blocks and combines them to create increasingly complex components.

### The Five Levels of Atomic Design

1. **Atoms** - Basic building blocks (buttons, inputs, labels, icons)
2. **Molecules** - Simple groups of atoms (form fields, search boxes)
3. **Organisms** - Complex groups of molecules and atoms (headers, forms, card components)
4. **Templates** - Page-level layouts that arrange organisms
5. **Pages** - Specific instances of templates with real content

## Installation

### Prerequisites

First, install Node.js:
```bash
kraken install nodejs
```

### Install Angular CLI

Then install Angular CLI:
```bash
kraken install angular
```

Verify the installation:
```bash
ng version
```

## Creating an Angular Application with Atomic Design

### 1. Create a New Angular Application

```bash
ng new my-app --routing --style=scss
cd my-app
```

### 2. Set Up the Atomic Design Structure

Create the component directories following Atomic Design principles:

```bash
# Create atoms directory and module
ng generate module shared/components/atoms
mkdir -p src/app/shared/components/atoms

# Create molecules directory and module
ng generate module shared/components/molecules
mkdir -p src/app/shared/components/molecules

# Create organisms directory and module
ng generate module shared/components/organisms
mkdir -p src/app/shared/components/organisms

# Create templates directory and module
ng generate module shared/components/templates
mkdir -p src/app/shared/components/templates

# Create pages directory and module
ng generate module shared/components/pages
mkdir -p src/app/shared/components/pages
```

### 3. Example: Building Components

#### Create an Atom (Button)

```bash
ng generate component shared/components/atoms/button --skip-tests
```

**button.component.ts:**
```typescript
import { Component, Input, Output, EventEmitter } from '@angular/core';

@Component({
  selector: 'app-button',
  templateUrl: './button.component.html',
  styleUrls: ['./button.component.scss']
})
export class ButtonComponent {
  @Input() label: string = 'Click me';
  @Input() type: 'primary' | 'secondary' | 'danger' = 'primary';
  @Input() disabled: boolean = false;
  @Output() clicked = new EventEmitter<void>();

  onClick() {
    if (!this.disabled) {
      this.clicked.emit();
    }
  }
}
```

**button.component.html:**
```html
<button 
  [class]="'btn btn-' + type" 
  [disabled]="disabled"
  (click)="onClick()">
  {{ label }}
</button>
```

#### Create a Molecule (Search Box)

```bash
ng generate component shared/components/molecules/search-box --skip-tests
```

**search-box.component.ts:**
```typescript
import { Component, Output, EventEmitter } from '@angular/core';

@Component({
  selector: 'app-search-box',
  templateUrl: './search-box.component.html',
  styleUrls: ['./search-box.component.scss']
})
export class SearchBoxComponent {
  searchTerm: string = '';
  @Output() search = new EventEmitter<string>();

  onSearch() {
    this.search.emit(this.searchTerm);
  }
}
```

**search-box.component.html:**
```html
<div class="search-box">
  <input 
    type="text" 
    [(ngModel)]="searchTerm" 
    placeholder="Search..."
    (keyup.enter)="onSearch()"
  />
  <app-button 
    label="Search" 
    type="primary"
    (clicked)="onSearch()">
  </app-button>
</div>
```

#### Create an Organism (Header)

```bash
ng generate component shared/components/organisms/header --skip-tests
```

**header.component.ts:**
```typescript
import { Component } from '@angular/core';

@Component({
  selector: 'app-header',
  templateUrl: './header.component.html',
  styleUrls: ['./header.component.scss']
})
export class HeaderComponent {
  onSearch(term: string) {
    console.log('Searching for:', term);
    // Implement search functionality
  }

  onLogin() {
    console.log('Login clicked');
    // Implement login functionality
  }
}
```

**header.component.html:**
```html
<header class="main-header">
  <div class="logo">My App</div>
  <app-search-box (search)="onSearch($event)"></app-search-box>
  <app-button 
    label="Login" 
    type="secondary"
    (clicked)="onLogin()">
  </app-button>
</header>
```

## Project Structure

Your project structure should look like this:

```
my-app/
├── src/
│   ├── app/
│   │   ├── shared/
│   │   │   └── components/
│   │   │       ├── atoms/
│   │   │       │   ├── button/
│   │   │       │   ├── input/
│   │   │       │   ├── label/
│   │   │       │   └── atoms.module.ts
│   │   │       ├── molecules/
│   │   │       │   ├── search-box/
│   │   │       │   ├── form-field/
│   │   │       │   └── molecules.module.ts
│   │   │       ├── organisms/
│   │   │       │   ├── header/
│   │   │       │   ├── footer/
│   │   │       │   ├── navigation/
│   │   │       │   └── organisms.module.ts
│   │   │       ├── templates/
│   │   │       │   ├── main-layout/
│   │   │       │   ├── auth-layout/
│   │   │       │   └── templates.module.ts
│   │   │       └── pages/
│   │   │           ├── home-page/
│   │   │           ├── about-page/
│   │   │           └── pages.module.ts
│   │   ├── app.component.ts
│   │   └── app.module.ts
│   └── styles.scss
```

## Best Practices

### 1. Component Reusability
- Keep atoms as simple and reusable as possible
- Avoid business logic in atoms and molecules
- Use Input/Output decorators for component communication

### 2. Styling
- Use SCSS for better style organization
- Create shared styles for atoms
- Use CSS variables for theming

### 3. Module Organization
```typescript
// atoms.module.ts example
import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { ButtonComponent } from './button/button.component';
import { InputComponent } from './input/input.component';

@NgModule({
  declarations: [
    ButtonComponent,
    InputComponent
  ],
  imports: [
    CommonModule
  ],
  exports: [
    ButtonComponent,
    InputComponent
  ]
})
export class AtomsModule { }
```

### 4. Testing Strategy
- Unit test atoms thoroughly
- Integration test molecules and organisms
- E2E test complete pages

## Common Angular CLI Commands

```bash
# Start development server
ng serve

# Build for production
ng build --prod

# Run tests
ng test

# Generate a new component
ng generate component path/component-name

# Generate a new service
ng generate service path/service-name

# Generate a new module
ng generate module path/module-name
```

## Resources

- [Angular Documentation](https://angular.io/docs)
- [Atomic Design by Brad Frost](https://atomicdesign.bradfrost.com/)
- [Angular Style Guide](https://angular.io/guide/styleguide)

## Troubleshooting

### Node.js or npm not found
Make sure you've installed the nodejs package:
```bash
kraken install nodejs
```

### Angular CLI not found
Reinstall Angular CLI:
```bash
kraken install angular
```

### Permission Issues
If you encounter permission issues, make sure you're running with appropriate privileges or check directory permissions.

## Support

For issues specific to Kraken OS packages, please refer to the Kraken Package Manager documentation or open an issue in the repository.
