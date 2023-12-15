import { defineConfig } from 'astro/config';
import yaml from '@rollup/plugin-yaml';

// https://astro.build/config
export default defineConfig({
  vite: {
    plugins: [yaml()]
  },
  site: 'https://drozd0-foobar.github.io/',
  base: '/semestral-db-astro/',
  compressHTML: true,
});