# Node.js Package for Kraken OS

This package provides Node.js runtime and npm package manager for Kraken OS.

## Version

Node.js v22.13.1 LTS (Long Term Support)

## What's Included

- **Node.js**: JavaScript runtime built on Chrome's V8 JavaScript engine
- **npm**: Node Package Manager for installing JavaScript packages
- **npx**: Package runner tool for executing Node packages

## Installation

```bash
kraken install nodejs
```

## Verification

After installation, verify that Node.js and npm are working:

```bash
node --version
# Expected output: v22.13.1

npm --version
# Expected output: 10.x.x (npm version bundled with Node.js 22.13.1)
```

## Usage

### Running JavaScript Files

Create a file called `hello.js`:
```javascript
console.log('Hello from Node.js on Kraken OS!');
```

Run it:
```bash
node hello.js
```

### Using npm

Install packages globally:
```bash
npm install -g package-name
```

Install packages locally in a project:
```bash
npm install package-name
```

### Initialize a New Node.js Project

```bash
mkdir my-project
cd my-project
npm init -y
```

## Common npm Commands

```bash
# Install dependencies from package.json
npm install

# Install a package and save to dependencies
npm install package-name --save

# Install a package and save to devDependencies
npm install package-name --save-dev

# Update packages
npm update

# Run scripts defined in package.json
npm run script-name

# List installed packages
npm list

# Check for outdated packages
npm outdated
```

## Dependencies

This package has no dependencies on other Kraken packages. It uses pre-built binaries from the official Node.js distribution.

## Package Details

- **Category**: extends
- **Source**: Official Node.js Linux x64 binaries
- **Installation Path**: /usr/local/
- **Binaries**: node, npm, npx

## Troubleshooting

### Node.js not found after installation

Make sure `/usr/local/bin` is in your PATH:
```bash
export PATH="/usr/local/bin:$PATH"
```

Add to your shell configuration file (.bashrc, .zshrc, etc.) to make it permanent.

### npm permission errors

If you encounter permission errors when installing global packages, you may need to configure npm to use a different directory or use sudo.

## Related Packages

- **angular**: Angular CLI for building web applications (depends on nodejs)

## Resources

- [Node.js Documentation](https://nodejs.org/docs/)
- [npm Documentation](https://docs.npmjs.com/)
- [Node.js GitHub Repository](https://github.com/nodejs/node)

## Support

For issues specific to this Kraken OS package, please open an issue in the KUR repository.
For Node.js-specific issues, refer to the official Node.js documentation.
