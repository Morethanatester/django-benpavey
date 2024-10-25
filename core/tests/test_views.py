from django.test import TestCase, override_settings
from django.urls import reverse

# Override STATICFILES_STORAGE to use StaticFilesStorage during tests
# This avoids issues with ManifestStaticFilesStorage requiring all static files to be present
@override_settings(STATICFILES_STORAGE='django.contrib.staticfiles.storage.StaticFilesStorage')
class ViewTests(TestCase):

    # Test that the home view returns a 200 status code and uses the correct template
    def test_home_view(self):
        response = self.client.get(reverse('home'))
        self.assertEqual(response.status_code, 200)
        self.assertTemplateUsed(response, 'core/home.html')

    # Test that the about view returns a 200 status code and uses the correct template
    def test_about_view(self):
        response = self.client.get(reverse('about'))
        self.assertEqual(response.status_code, 201) # intentional fail
        self.assertTemplateUsed(response, 'core/about.html')