/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    "./src/main/webapp/**/*.jsp",
    "./src/main/webapp/**/*.html",
    "./src/main/webapp/**/*.js",
    "./src/main/webapp/includes/**/*.jsp",
  ],
  darkMode: "class",
  theme: {
    extend: {
      colors: {
        primary: {
          light: "#2563EB",
          DEFAULT: "#1D4ED8",
          dark: "#1E40AF",
        },
        background: {
          light: "#FFFFFF",
          dark: "#1F2937",
        },
        text: {
          light: "#1F2937",
          dark: "#F9FAFB",
        },
      },
      fontFamily: {
        sans: ["Inter", "sans-serif"],
      },
    },
  },
  plugins: [],
};
