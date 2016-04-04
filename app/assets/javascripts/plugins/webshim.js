webshim.setOptions({
  'basePath': '/assets/individual/shims/',
  'extendNative': false,
  'forms-ext': {
    replaceUI: 'true',
    types: 'range',
    range: {
      classes: 'hide-ticks',
      calcTrail: false,
      animate: false,
    }
  }
});

webshim.polyfill('forms-ext');
