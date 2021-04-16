using System.Collections.Generic;

namespace OpenWhiskDotnetNoJsonTest
{
    public class Class1
    {
        public Dictionary<string, object> Main(Dictionary<string, object> owParams)
        {
            var output = new Dictionary<string, object>();
            foreach (var owParam in owParams)
            {
                output.Add(owParam.Key, owParam.Value);
            }

            output.Add("success", true);
            
            return output;
        }
    }
}
