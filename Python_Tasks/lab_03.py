class Solution:
    def isValid(self, s: str) -> bool:
        stack = []
        
        mapping = {
            '(':')',
            '[':']',
            '{':'}'            
        }
        
        for char in s:
            if char in mapping.keys():
                stack.append(mapping[char])
            elif not stack or stack[-1] != char:
                return False
            else:
                stack.pop()
        
        return not stack

obj = Solution()

print(obj.isValid('({[]})'))
