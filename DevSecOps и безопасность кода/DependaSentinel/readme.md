# DependaSentinel

GitHub Action, снижающая false-positive CVE до ≈ 15 % за счёт AST-анализа вызовов функций.

## Установка

Добавьте в репозиторий файл `.github/workflows/dependasentinel.yml`:

```yaml
uses: your-org/dependasentinel@v1
with:
  fail-on-severity: moderate
  github-token: ${{ secrets.GITHUB_TOKEN }}