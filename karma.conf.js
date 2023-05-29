module.exports = function (config) {
    config.set({
        frameworks: ['jasmine', '@angular/cli'],
        plugins: [
            require('karma-jasmine'),
            require('karma-chrome-launcher'),
            require('@angular/cli/plugins/karma'),
            require('karma-jasmine'),
            require('karma-chrome-launcher'),
            require('@angular/cli/plugins/karma'),
            require('karma-coverage-istanbul-reporter')
        ],
        files: [
            { pattern: './src/test.ts', watched: false }
        ],
        preprocessors: {
            './src/test.ts': ['@angular/cli']
        },
        mime: {
            'text/x-typescript': ['ts', 'tsx']
        },
        browsers: ['Chrome', 'ChromeHeadless', 'ChromeHeadlessNoSandbox', 'Puppeteer'],
        customLaunchers: {
            Puppeteer: {
                base: 'ChromeHeadless',
                flags: [
                    '--no-sandbox',
                    '--disable-setuid-sandbox',
                    '--disable-dev-shm-usage'
                ],
                debug: false
            }
        },

        singleRun: true
    });
};
